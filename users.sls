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
{{ name }}_keydir:
  file.directory:
    - name: {{ user['home'] }}/.ssh
    - user: {{ name }}
    - dir_mode: 0700
    - makedirs: True
    - require:
      - user: {{ name }}

{% for key_prv in user.get('ssh_key_prv', []) %}
add_{{ key_prv }}:
  file.managed:
    - name: {{ user['home'] }}/.ssh/{{ key_prv }}
    - source: {{ user['ssh_key_dir'] }}/{{ key_prv }}
    - user: {{ name }}
    - mode: 600
{% endfor %}
{% endif %}

{% if 'ssh_auth' in user %}
sshkey_{{ name }}:
  ssh_auth.present:
    - user: {{ name }}
    - source: {{ user['ssh_key_dir'] }}/{{ user['ssh_auth'] }}
    - mode: 644
{% endif %}
{% endfor %}

#### del user ######
{% for rmuser in pillar.get('absent_users', []) %}
user_remove_{{ rmuser }}:
 user.absent:
   - name: {{ rmuser }}
   - purge: True
{% endfor %}

