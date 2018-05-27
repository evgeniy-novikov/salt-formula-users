users:
  canonical:
    fullname: canonical
    home: /home/canon
    uid: 4000
    gid: 100
    groups:
      - users
      - root
    sudouser: True
    ssh_auth: salt://tests/ubuntu.pub
    ssh_key_prv: salt://tests/ubuntu.pem
#      - salt://tests/ubuntu_vm2.pem

absent_users:
  - redhat

