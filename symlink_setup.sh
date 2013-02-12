#/bin/bash

#This should be automated by the salt overlord...

unlink /etc/salt/cloud
ln -s /srv/cloudstate/cloud /etc/salt/cloud

unlink /etc/salt/cloud.profiles
ln -s /srv/cloudstate/cloud.profiles /etc/salt/cloud.profiles

unlink /etc/salt/master
ln -s /srv/cloudstate/master /etc/salt/master


# ln -s /srv/cloudstate/cloud /etc/salt/cloud
# ln -s /srv/cloudstate/cloud.profiles /etc/salt/cloud.profiles
# ln -s /srv/cloudstate/master /etc/salt/master
# ln -s /srv/cloudconf/salt/role-api/sync-s3-war.sh /root/sync-s3-war.sh