#Installation instructions on ubuntu 12.04-1 LTS

##checkout this git repo to `/srv/`

Setup the symlinks:

```bash
ln -s /srv/cloudstate/cloud /etc/salt/cloud
ln -s /srv/cloudstate/cloud.profiles /etc/salt/cloud.profiles
ln -s /srv/cloudstate/master /etc/salt/master
ln -s /srv/cloudconf/salt/role-api/sync-s3-war.sh /root/sync-s3-war.sh
```