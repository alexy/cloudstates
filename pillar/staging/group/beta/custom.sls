#!yaml

include:
  - saltmine.pillar.env_globals

s3war_bucket:    's3://net.vrsl.war'
s3nodejs_bucket: 's3://net.vrsl.beta'

# NB have to specify all keys, as the whole is overwritte!
war:
    api:  
      source:    api.staging.war
      target:    api.war
      dotversal: ${saltmine_tomcat7_homedir}/.versal
      db_url:    api-beta-staging.c348djtkl0hn.us-west-2.rds.amazonaws.com/api
      db_user:   play
      db_pwd:    replay
    auth:
      source:    frontdoor.staging.war
      target:    frontdoor.war
      dotversal: ${saltmine_tomcat7_homedir}/.versal-frontdoor
      db_url:    users-beta-staging.c348djtkl0hn.us-west-2.rds.amazonaws.com/users
      db_user:   door
      db_pwd:    backdoor
      smtp:      localhost

api_key: SECRET

node_bundle:    pb-express-site-staging.tar.bz2
node_api_url:   "http://stagebeta.versal.com/api"
node_auth_url:  "http://stagebeta.versal.com/frontdoor"

s3cdn_bucket:    'com.versal.beta.assets.staging'

backend_static_servers:
  server1:
    name: com.versal.beta.staging.s3-website-us-west-2.amazonaws.com
    dns:  com.versal.beta.staging.s3-website-us-west-2.amazonaws.com
