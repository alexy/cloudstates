#!mako|yaml

include:
  - saltmine.pillar.env_globals

<% saltmine_tomcat7_homedir='/usr/share/tomcat7' %>

s3war_bucket:    's3://net.vrsl.war'

# NB have to specify all keys, as the whole is overwritten!
war:
    api:  
      source:    platform2.war
      target:    platform2.war
      dotversal: ${saltmine_tomcat7_homedir}/.versal-platform2
      db_url:    platform2.c348djtkl0hn.us-west-2.rds.amazonaws.com/platform2
      db_user:   platform2
      db_pwd:    plotzplotz

api_key: SECRET

s3cdn_bucket:   'com.versal.beta.assets.staging'
