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


##---- Unused -----
#
node_bundle:    pb-express-site-prod.tar.bz2
# endpoints
node_site_url:   "http://testing.versal.com"
node_api_url:   "http://alpha.versal.com/api"
#
##-----------------

api_key: SECRET
adminIDs: '[
  "38211",
  "38276",
  "38351",
  "38366",
  "111051",
  "118516"
]'
## URLs

siteUrl: 'http://staging.versal.com'
apiUrl: 'https://stagingstack.versal.com/api2'
playerUrl: 'https://stagingstack.versal.com/player2'
timerPrefix: 'staging.versal.com'

#ports
node_app_port: '3001'
## mailer block settings
mailer_host: 'smtp.mandrillapp.com'
mailer_port: '587'
mailer_ssl: 'false'
mailer_auth: 'true'
mailer_user: 'versal'
mailer_password: 'wWt2wn4S9Dt7K9EMfLIMPA'
mailer_from: 'info@versal.com'
mailer_templatePrefix: 'versal.com'

#database
node_db_url:    'nodesites-prod.c348djtkl0hn.us-west-2.rds.amazonaws.com'
node_db_user:   'nodesites'
node_db_pwd: 'jech7wez'

#memcache
node_memcache_url: 'nodesites-prod.tbbxfu.0001.usw2.cache.amazonaws.com'
node_memcache_port: '11211'
<%! from time import strftime as time %>
cachePrefix: 'staging_${"%s" | time}'

# #TODO clean this up. arg why is this required? shouldn't be here.
# s3cdn_bucket:   'com.versal.beta.assets.staging'
