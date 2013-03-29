#!mako|yaml

include:
  - saltmine.pillar.env_globals

<% saltmine_tomcat7_homedir='/usr/share/tomcat7' %>

s3war_bucket:    's3://com.versal.platform2'

# NB have to specify all keys, as the whole is overwritten!
war:
    api:  
      source:    platform2.war
      target:    api.war
      dotversal: ${saltmine_tomcat7_homedir}/.versal-platform2
      db_url:    api-beta-testing.c348djtkl0hn.us-west-2.rds.amazonaws.com/api
      db_user:   play
      db_pwd:    replay

api_key: SECRET