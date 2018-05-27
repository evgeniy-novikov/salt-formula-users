{% from "users/map.jinja" import users with context %}

{% for name, user in pillar.get('users', {}).items() %}
{{ name }}:
  user.present:
    - fullname: {{ user['fullname'] }}
    {% if 'home' in user -%}
    - home: {{ user['home'] }}
    {% else %}
    - home: /home/{{ name }}
    {% endif %}
    {% if 'uid' in user -%}
    - uid: {{ user['uid'] }}
    {% endif -%}
    {% if 'gid' in user -%}
    - gid: {{ user['gid'] }}
    {% endif -%}
    - groups:
      {% for group in user.get('groups', []) -%}
      - {{ group }}
      {% endfor %}

{% if 'sudouser' in user %}
/etc/sudoers.d/{{ name }}:
  file.managed:
  - source: salt://templates/sudoers.d.jinja2
  - template: jinja
  - context:
    user_name: {{ name }}
{% endif %}

{% if 'ssh_key_prv' in user %}
{% for key_prv in user.get('ssh_key_prv', []) -%}
add_{{ key_prv }}:
  file.managed:
    - name: {{ user['home'] }}/.ssh/{{ key_prv }}
    - source: {{ user['ssh_key_dir'] }}/{{ key_prv }}
{% endfor %}
{% endif %}

{% if 'ssh_auth' in user %}
sshkey_{{ name }}:
  ssh_auth.present:
    - user: {{ name }}
    - source: {{ user['ssh_key_dir'] }}/{{ user['ssh_auth'] }}
{% endif %}
{% endfor %}



#### del user ######
{% for rmuser in pillar.get('absent_users', []) %}
user_remove_{{ rmuser }}:
 user.absent:
   - name: {{ rmuser }}
   - purge: True
{% endfor %}
