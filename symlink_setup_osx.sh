#/bin/bash

#This should be automated by the salt overlord...

#

HOME_DIRECTORY=/Users/mini/Versal

unlink /etc/salt/cloud
ln -s $HOME_DIRECTORY/cloudstate/cloud /etc/salt/cloud

unlink /etc/salt/cloud.profiles
ln -s $HOME_DIRECTORY/cloudstate/cloud.profiles /etc/salt/cloud.profiles

unlink /etc/salt/master
ln -s $HOME_DIRECTORY/cloudstate/master /etc/salt/master

#unlink /root/sync-s3-war.sh 
#ln -s /srv/cloudconf/salt/role-api/sync-s3-war.sh /root/sync-s3-war.sh