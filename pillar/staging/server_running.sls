#!yaml

# This file is generated by a python script. The script modifies the entries based on the 
# output of the yaml file from 'salt-cloud -Q'.

# When a server is started, the server is added to servers_status. If a server is terminated, 
# it is removed. If a server is 'stopped', it shows as state: STOPPED

server_status:
  - apple-1-1.vrsl.net:
    roles: api
    state: RUNNING
  - banana-1-1.vrsl.net:
    roles: api
    state: RUNNING
  - cherry-1-1.vrsl.net:
    roles: api
    state: RUNNING
  - apple-1-2.vrsl.net:
    roles: api
    state: RUNNING
  - banana-1-2.vrsl.net:
    roles: api
    state: RUNNING
  - cherry-1-2.vrsl.net:
    roles: api
    state: RUNNING