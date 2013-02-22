#!mako|yaml

# global default pillar variables for use in all environments
# these can be overwritten in individual environments.

<%
environment=grains['environment']
if 'group' in grains:
	group = grains['group']
else:
	group = None
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
war_basedir:  'common/states/share/role-war'

% if group:
domain: ${group}-${environment}.vrsl.net
% else:
domain: ${environment}.vrsl.net
% endif

s3war_bucket: 's3://net.vrsl.war'
war:      
  api:
    source: api.staging.war
    target: api.war

message_do_not_modify: 'This file is managed by Salt. Do Not Modify.'


saltmine_crontab_file_root: '/root/crontab_file_root'
saltmine_crontab_path: 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

minion:
  log_level: debug
  startup_states: sls
  sls_list:
    - saltmine.pkgs.mako
  grains:
    environment: ${environment}
% if group:
    group: ${group}
% endif
