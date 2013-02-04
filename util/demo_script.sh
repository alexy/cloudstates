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
