#!mako|yaml

#https://salt.readthedocs.org/en/latest/topics/pillar/index.html
#pillar data is available GLOBALLY to all scripts and minions!
#to sync pillar data with minions manually, do:
# salt '*' saltutil.refresh_pillar

#To view Pillar data:
# salt '*' pillar.data

#To target minions based on pillar data...
# salt -I 'somekey:specialvalue' test.ping

# First, get the grain of the server based on the 
# 'environment' grain. Possible update would verify
# this or use the server name also.

<%
environment=grains['environment']
if 'group' in grains:
  group=grains['group']
else:
  group=None
%>

base:
  '*':
    - base
# pillar loading for all environments. 
# if the group grain is set, load the group init.sls
# if not, load the environment init.sls
% if environment in ['localdev', 'develop', 'staging', 'testing', 'prod']:
  % if group is not None:
    - ${environment}.groups.${group}
  % else:
    - ${environment}
  % endif
% endif


