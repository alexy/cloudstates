#!yaml

s3war_bucket: 's3://net.vrsl.war'

# NB have to specify all keys, as the whole is overwritte!
war:
    api:
      source: api.staging.war
      target: api.war
    auth:
      source: frontdoor.war
      target: frontdoor.war

backend_static_servers:
  server1:
    name: com.versal.web.s3-website-us-west-2.amazonaws.com
    dns:  com.versal.web.s3-website-us-west-2.amazonaws.com