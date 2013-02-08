#!mako|yaml

# global default pillar variables for use in all environments
# these can be overwritten in individual environments.

<%
environment=grains.get('environment')
%>

provisioner: salt-cloud

environment: ${environment}

salt_master: mcp-${environment}.vrsl.net

% if environment == 'localdev':
username: vagrant
% else:
username: ubuntu
% endif

domain: ${environment}.vrsl.net
s3war_bucket: 's3://com.vrsl.net'
api_war:      api.default.war

backend_static_servers:
  server1:
    name: net.vrsl.web.s3-website-us-west-2.amazonaws.com
    dns: net.vrsl.web.s3-website-us-west-2.amazonaws.com
  server2:
    name: net.vrsl.web.s3-website-us-west-2.amazonaws.com
    dns: net.vrsl.web.s3-website-us-west-2.amazonaws.com

minion:
  log_level: debug
  startup_states: sls
  sls_list:
    - common.services.mako
  grains:
    environment: ${environment}