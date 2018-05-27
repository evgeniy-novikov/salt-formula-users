 Users:

Formula to configure users via pillar.

1. Need to add to /etc/salt/master
    file_roots:
       base:
	 - /srv/salt-formula-users/
    pillar_roots:
	base:
         - /srv/salt-formula-users/tests/pillar

2. Restart salt-master
3. Copy salt-formula-users to /srv directory
4. If you want to create user you need to change one of the pillars file
    - ubuntu.sls - if you have ubuntu linux
    - centos.sls - if you have cantos linux
file example:

users:   				- not change
  redhat:				- name of user 
    fullname: redhat			- name of user.
    home: /home/redhat			- user directory
    uid: 4000				- uid 
    gid: 100				- gid
    groups:				- groups
      - users				- name of group
      - root				- name of group 
    sudouser: Ture			- if you need to 'sudo' without password
    ssh_auth: salt://tests/centos.pub	- file with ssh public key
    ssh_key_prv: salt://tests/centos.pem - file with ssh private key 

absent_users:				- not change
  - canonical				- user with you want to delete from your system

if not need to delete some user comment to this parameters
    # absent_users:
    #  - canonical

if you need to add more then one public key you need to copy key to file
ssh_auth: salt://tests/centos.pub 
!!!! each key with a new line

5. Before start need to check on errors 
    salt 'minion-name' state.sls users test=true

6. start the formula 
    salt 'minion-name' state.sls users