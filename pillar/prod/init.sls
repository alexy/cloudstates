#!yaml

include:
  - common.env_globals
  - prod.server_roles

s3war_bucket: 's3://net.vrsl.war'
api_war:      api.dmv.war

backend_static_servers:
  server1:
    name: com.versal.web.s3-website-us-west-2.amazonaws.com
    dns:  com.versal.web.s3-website-us-west-2.amazonaws.com