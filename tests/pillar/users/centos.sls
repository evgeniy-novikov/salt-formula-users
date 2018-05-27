users:
  redhat:
    fullname: redhat
    home: /home/redhat
    uid: 4000
    gid: 100
    groups:
      - users
      - root
    sudouser: Ture
    ssh_key_dir: salt://tests
    ssh_auth: centos.pub
    ssh_key_prv:
      - centos.pem

absent_users:
  - canonical
