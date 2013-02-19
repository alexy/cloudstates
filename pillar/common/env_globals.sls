#!mako|yaml

# global default pillar variables for use in all environments
# these can be overwritten in individual environments.

<%
environment=grains['environment']
%>

provisioner: salt-cloud

environment: ${environment}

salt_master: mcp-${environment}.vrsl.net

% if environment == 'localdev':
username: vagrant
% else:
username: ubuntu
% endif

salt_basedir: '/srv/cloudconf/salt'
war_basedir: 'common/states/role-api'

domain: ${environment}.vrsl.net
s3war_bucket: 's3://net.vrsl.war'
api_war:      api.staging.war

message_do_not_modify: 'This file is managed by Salt. Do Not Modify.'

backend_static_servers:
  server1:
    name: net.vrsl.web.s3-website-us-west-2.amazonaws.com
    dns: net.vrsl.web.s3-website-us-west-2.amazonaws.com

saltmine_crontab_file_root: '/root/crontab_file_root'
saltmine_crontab_path: 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

minion:
  log_level: debug
  startup_states: sls
  sls_list:
    - saltmine.services.mako
  grains:
    environment: ${environment}