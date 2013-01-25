#!yaml

# This file is an example of the file created by our mako template. The script modifies the entries based on the output of the yaml file from 'salt-cloud -Q'.

# When a server is started, the server is added to servers_status. If a server is # terminated, it is removed. If a server is 'stopped', it shows as state: STOPPED

server_status:
  - name: apple-0-1.vrsl.net
    roles: api
    public_dns: 192.168.1.1
    private_dns: 127.0.0.1
    state: RUNNING
  - name: banana-0-1.vrsl.net
    roles: api
    state: RUNNING
    public_dns: 192.168.1.1
    private_dns: 127.0.0.1
  - name: cherry-0-1.vrsl.net
    roles: api
    state: RUNNING
    public_dns: 192.168.1.1
    private_dns: 127.0.0.1