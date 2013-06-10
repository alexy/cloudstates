#!mako|yaml

<% 
  # saltmine_tomcat7_homedir  = '/usr/share/tomcat7'
  # saltmine_tomcat7_webappsdir = '/var/lib/tomcat7/webapps'

  environment               = grains['environment']
  group                     = grains['group'] if 'group' in grains else None
  roles                     = grains['roles'][0] if 'roles' in grains else None

  # war_customname            = 'api2.war'
  # dotversal_basename      = 'versal-platform2'
  # dotversal_customname      = '.'+dotversal_basename
  # dotversal_fullname        = 'dot'+dotversal_basename
%>

node_bundle:    alpha-express-site-prod.tar.bz2
node_api_url:   "http://alpha.versal.com/api"
node_auth_url:  "http://alpha.versal.com/frontdoor"

api_key: SECRET

# #TODO clean this up. arg why is this required? shouldn't be here.
# s3cdn_bucket:   'com.versal.beta.assets.staging'
