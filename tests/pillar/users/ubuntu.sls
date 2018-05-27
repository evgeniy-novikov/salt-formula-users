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
    ssh_key_dir: salt://tests
    ssh_auth: ubuntu.pub
    ssh_key_prv:
       - ubuntu.pem
       - ubuntu_vm2.pem

absent_users:
  - redhat

