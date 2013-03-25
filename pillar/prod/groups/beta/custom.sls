#!mako|yaml

include:
  - saltmine.pillar.env_globals

<% saltmine_tomcat7_homedir='/usr/share/tomcat7' %>

s3war_bucket:    's3://net.vrsl.war'
s3nodejs_bucket: 's3://net.vrsl.beta'

# NB have to specify all keys, as the whole is overwritte!
war:
    api:  
      source:    api.prod.war
      target:    api.war
      dotversal: ${saltmine_tomcat7_homedir}/.versal
      db_url:    api-beta-prod.c348djtkl0hn.us-west-2.rds.amazonaws.com/api
      db_user:   play
      db_pwd:    replay
    auth:
      source:    frontdoor.prod.war
      target:    frontdoor.war
      dotversal: ${saltmine_tomcat7_homedir}/.versal-frontdoor
      db_url:    users-beta-prod.c348djtkl0hn.us-west-2.rds.amazonaws.com/users
      db_user:   door
      db_pwd:    backdoor
      smtp:      localhost

api_key: SECRET

node_bundle:    pb-express-site-prod.tar.bz2
node_api_url:   "http://beta.versal.com/api"
node_auth_url:  "http://beta.versal.com/frontdoor"

s3cdn_bucket:    'com.versal.beta.assets'

backend_static_servers:
  server1:
    name: com.versal.beta.s3-website-us-west-2.amazonaws.com
    dns:  com.versal.beta.s3-website-us-west-2.amazonaws.com

## haproxy basic auth
haproxy_basic_auth:
  realm:     Versal
  acl:       AuthOkay_Versal
  user_list: UsersFor_Versal
  users:
    versal: privatebeta2013
