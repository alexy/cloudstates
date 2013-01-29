#!/bin/bash

## Run this script on mcp-staging.vrsl.net as root user.

## Connect to mcp-staging.vrsl.net
#ssh -i ~/keys/versal1or.pem ubuntu@mcp-staging.vrsl.net
#sudo -i
#####

function pause { 
	echo '(continue)'
	read -n 1 -s 
}

## Create new map file
cd /srv/cloudstate/util

clear

echo Welcome to Versal DevOps

echo

echo Cloud profiles -- image definitions with locations for salt-cloud

pause

# show/create profiles file...
./uber.py --profiles | more

./uber.py --profiles > ../cloud.profiles

pause

echo Server roles -- maps for salt-cloud to boot from

# show/create demo api and lb map files
./uber.py --role api | more
./uber.py --role lb  | more

./uber.py --role api > ../demo_api.map
./uber.py --role lb >  ../demo_lb.map

#go up directory
cd ..

echo Inspect the status of the API servers

pause


# show the instances don't yet exist.
salt-cloud -m demo_api.map -Q

echo Inspect the status of the Load Balancer servers

pause

salt-cloud -m demo_lb.map -Q

echo Stand up everything

pause

# boot the instances
salt-cloud -m demo_api.map -P
salt-cloud -m demo_lb.map -P

#reset screen
reset

echo Inspect the running status by pinging all of the running minions

pause

salt '*' test.ping

# echo Ping and output the status as YAML

# pause

# salt '*' test.ping --out=yaml

SERVERS=/srv/cloudstate/pillar/staging/salt_cloud_live_instances.sls

# update live instance list
/usr/bin/salt-cloud -Q --out=yaml > $SERVERS

echo Show the running server status

more $SERVERS

echo Create or update the DNS records for our server names and actual IPs

pause

# update dns
python /root/update-dns.py --ensure $SERVERS

echo Configure all the individual servers to their destined roles

pause

# autoconfigure all machines
salt '*' state.highstate

echo Enjoy!
