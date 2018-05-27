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
    ssh_auth: salt://tests/centos.pub
    ssh_key_prv: salt://tests/centos.pem

absent_users:
  - canonical
