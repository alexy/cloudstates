#!/bin/bash

## Run this script on mcp-staging.vrsl.net as root user.

## Connect to mcp-staging.vrsl.net
#ssh -i ~/keys/versal1or.pem ubuntu@mcp-staging.vrsl.net
#sudo -i
#####

function pause { 
	read -n 1 -s 
}

## Create new map file
cd /srv/cloudstate/util

pause

# show/create profiles file...
./uber.py --profiles | more

pause

./uber.py --profiles > ../cloud.profiles

# show/create demo api and lb map files
./uber.py --role api | more
./uber.py --role lb  | more

pause

./uber.py --role api > ../demo_api.map
./uber.py --role lb >  ../demo_lb.map

#go up directory
cd ..

# show the instances don't yet exist.
salt-cloud -m demo_api.map -Q

pause

salt-cloud -m demo_lb.map -Q

pause

# boot the instances
salt-cloud -m demo_api.map -P
salt-cloud -m demo_lb.map -P

#reset screen
reset

pause

# ping the machines:
salt '*' test.ping --out=yaml

pause

salt '*' test.ping

SERVERS=/srv/cloudstate/pillar/staging/salt_cloud_live_instances.sls

# update live instance list
/usr/bin/salt-cloud -Q --out=yaml > $SERVERS

more $SERVERS

pause

# update dns
python /root/update-dns.py --ensure $SERVERS

pause

# autoconfigure all machines
salt '*' state.highstate
