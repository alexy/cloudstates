#!mako|yaml

# global default pillar variables for use in all environments
# these can be overwritten in individual environments.

<%
environment=grains['environment']
if 'group' in grains:
	group = grains['group']
else:
	group = None

username = 'ubuntu' if environment != 'localdev' else 'vagrant'

%>

provisioner: salt-cloud

environment: ${environment}

salt_master: mcp-${environment}.vrsl.net

username: ${username}

salt_basedir: '/srv/cloudconf/salt'
war_basedir:  'common/states/share/role-war'

% if group is not None:
domain: ${group}-${environment}.vrsl.net
% else:
domain: ${environment}.vrsl.net
% endif

s3war_bucket: 's3://net.vrsl.war'
war:      
  api:
    source: api.${environment}.war
    target: api.war

<%
app_name='pb-express-site'
base_dir='/home/' + username
%>

## App Version Settings
saltmine_boto_version:   '2.7.0'


## haproxy basic auth
haproxy_basic_auth:
  realm:     Versal
  acl:       AuthOkay_Versal
  user_list: UsersFor_Versal
  users:
    versal: m0n0sp4c3d

## node.js

saltmine_nodejs_version: '0.10.0'

node:
  name:                 ${app_name}
  curl_auth:            '-u jenkins:jenkins123!'
  base_url:             http://artifactory.versal.com/libs-snapshot-local/com/versal/${app_name}
  bundle:               ${app_name}-SNAPSHOT.tar.bz2
  salt_bundle_dir:      ${environment}/states/group/beta/role-nodejs
  server_bundle_dir:    ${base_dir}
  server_app_dir:       ${base_dir}/${app_name}-salt


saltmine_crontab_file_root: '/root/crontab_file_root'
saltmine_crontab_path: 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

## cron

<%
every_ten_minutes='*/10 * * * *'
a_minute_after_every_ten='1,11,21,31,41,51 * * * *'
two_minutes_after_every_ten='2,12,22,32,42,52 * * * *'
%>

cron:
  api:
    pull: '${every_ten_minutes}'
    push: '${two_minutes_after_every_ten}'
  nodejs:
    pull: '${every_ten_minutes}'
    push: '${two_minutes_after_every_ten}'

## minion

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

