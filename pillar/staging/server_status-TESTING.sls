#!yaml

# This file is an example of the file created by our mako template. The script modifies the entries based on the output of the yaml file from 'salt-cloud -Q'.

# When a server is started, the server is added to servers_status. If a server is # terminated, it is removed. If a server is 'stopped', it shows as state: STOPPED

server_status:
  agnon-region-0-0-staging.vrsl.net:
    - roles: lb
    - public_dns: ec2-54-245-178-203.us-west-2.compute.amazonaws.com
    - private_dns: ip-10-249-58-225.us-west-2.compute.internal
    - state: RUNNING
  apple-region-0-0-staging.vrsl.net:
    - roles: api
    - public_dns: ec2-50-112-28-75.us-west-2.compute.amazonaws.com
    - private_dns: ip-10-249-12-77.us-west-2.compute.internal
    - state: RUNNING
  banana-region-0-0-staging.vrsl.net:
    - roles: api
    - public_dns: ec2-54-245-178-203.us-west-2.compute.amazonaws.com
    - private_dns: ip-10-249-58-225.us-west-2.compute.internal
    - state: RUNNING
  cherry-region-0-0-staging.vrsl.net:
    - roles: api
    - public_dns: ec2-54-245-178-203.us-west-2.compute.amazonaws.com
    - private_dns: ip-10-249-58-225.us-west-2.compute.internal
    - state: RUNNING

