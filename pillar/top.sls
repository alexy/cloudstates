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
environment=grains.get('environment')
%>

base:
  '*':
    - base
# pillar loading for all environments. 
# Check the init.sls for each pillar.

% if environment in ['localdev', 'dev', 'staging', 'prod']:
    - ${environment}
% endif

