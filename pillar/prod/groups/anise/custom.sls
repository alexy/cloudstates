#!mako|yaml

<% saltmine_tomcat7_homedir='/usr/share/tomcat7' %>

s3war_bucket:    's3://net.vrsl.war'

# NB have to specify all keys, as the whole is overwritten!
war:
    api:  
      source:    platform2.war
      target:    platform2.war
      dotversal: ${saltmine_tomcat7_homedir}/.versal-platform2
      db_url:    aphid-region-0-0-common-prod.vrsl.net/platform2
      db_user:   platform2
      db_pwd:    plotzplotz

api_key: SECRET

#TODO clean this up. arg why is this required? shouldn't be here.
s3cdn_bucket:   'com.versal.beta.assets.staging'
