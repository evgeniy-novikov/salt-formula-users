 Users:

Formula to configure users via pillar.

1. Need to add to /etc/salt/master
```bash
  file_roots:
     base:
       - /srv/salt-formula-users/
    pillar_roots:
	base:
         - /srv/salt-formula-users/tests/pillar
```
2. Restart salt-master

3. Clone download the repository into a directory:
```bash
    cd /srv
    git clone https://github.com/1-0/salt-formula-users.git
```
4. If you want to create user you need to change one of the pillars file
    - ubuntu.sls - if you have ubuntu linux
    - centos.sls - if you have cantos linux
file example:

```yaml
users:                                  - not change
  - redhat:                             - name of user 
  - fullname: redhat                    - name of user.
  - home: /home/redhat                  - user directory
  - uid: 4000                           - uid 
  - gid: 100                            - gid
  - groups:                             - groups
     - users				- name of group
     - root				- name of group 
  - sudouser: Ture			- if you need to 'sudo' without password
  - ssh_key_dir: salt://tests		- folder with ssh keys
  - ssh_auth: centos.pub		- file with ssh public key
  - ssh_key_prv:			- not change
     - centos.pem			- private ssh key


absent_users:				- not change
  - canonical				- user with you want to delete from your system
```

if not need to delete some user comment to this parameters
```bash
absent_users:
  - canonical
```

if you need to add more then one public key you need to copy key to file
ssh_auth: centos.pub 
!!!! each key with a new line

if you need to add more then one private key you need to add key file
in directory /srv/salt-formula-users/tests and add name of file to pillar like in exemple
```yaml
ssh_key_prv:
  - centos.pem
  - centos2.pem
```
5. Before start need to check on errors 
```bash
    salt 'minion-name' state.sls users test=true
```
6. start the formula 
```bash
    salt 'minion-name' state.sls users
```