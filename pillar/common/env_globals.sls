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
% else:
domain: ${environment}.vrsl.net
% endif

s3war_bucket: 's3://net.vrsl.war'
war:      
  api:
    source: api.staging.war
    target: api.war

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
    - saltmine.pkgs.mako
  grains:
    environment: ${environment}
% if group:
    group: ${group}
% endif

# temporarily set group grains here:

# gtg 

<%
#load pillar function here... this won't work don't think.
server_status = pillar['server_status']



# TODO based on current env & group, return a list of the roles to proxy
# role_proxylist = roles_to_proxy(server_status)

role_proxylist = ['api', 'nodejs']

if grains.has_key('group'):
  group = grains['group']
else:
  group = None
%>

saltmine_haproxy_settings:
  stats_enable: enable
  stats_login: versal
  stats_password: il1kev3rs4l
  default_backend: backend-static

% if server_status is not None:
saltmine_haproxy_backends:

  - name: backend-static
    server_port: 80
    options:
      - 'reqdel ^Host.*'
      - 'reqadd Host:\ ${backend_static_servers[server]['dns']}'
      - 'option httpchk GET /'
    server_options:
      - 'weight 1 check port 80 observe layer7'
    servers:
      - name: net.vrsl.web.s3-website-us-west-2.amazonaws.com
        dns: net.vrsl.web.s3-website-us-west-2.amazonaws.com

  % for roles in ['api']:
  - name: backend-${roles}
    server_port: '8080'
    options:
      - 'balance     leastconn'
      - 'option httpchk GET /api/health'
    server_options:
      - 'weight 1 check port 8080 observe layer7'
    acl: '${roles}_request'
    matcher: 'api'
    match_type: 'url_sub'
    servers:
    % for server in server_status:
      % if group is not None: # if any group grain is set, match groups

        % if group == server_status[server]['group'] and server_status[server]['roles'] == roles and server_status[server]['environment'] == environment and server_status[server]['state'] != 'TERMINATED':
      - name: ${server}
        dns: ${server_status[server]['private_dns']}
        % endif

      % else: # if no group grains are set, match environments only. for now, needed to keep compatible with non-named groups.

        % if server_status[server]['roles'] == roles and server_status[server]['environment'] == environment and server_status[server]['state'] != 'TERMINATED':
      - name: ${server}
        dns: ${server_status[server]['private_dns']}
        % endif
      % endif
    % endfor

  % for roles in ['nodejs']:
  - name: backend-${roles}
    server_port: '8080'
    options:
      - 'balance     leastconn'
      - 'option httpchk GET /api/health'
    server_options:
      - 'weight 1 check port 8080 observe layer7'
    acl: '${roles}_request'
    matcher: 'api'
    match_type: 'url_sub'
    servers:
    % for server in server_status:
      % if group is not None: # if any group grain is set, match groups

        % if group == server_status[server]['group'] and server_status[server]['roles'] == roles and server_status[server]['environment'] == environment and server_status[server]['state'] != 'TERMINATED':
      - name: ${server}
        dns: ${server_status[server]['private_dns']}
        % endif

      % else: # if no group grains are set, match environments only. for now, needed to keep compatible with non-named groups.

        % if server_status[server]['roles'] == roles and server_status[server]['environment'] == environment and server_status[server]['state'] != 'TERMINATED':
      - name: ${server}
        dns: ${server_status[server]['private_dns']}
        % endif
      % endif
    % endfor

  % endfor