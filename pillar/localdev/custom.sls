#!yaml

provisioner: vagrant
domain: localhost
salt_master: 10.0.2.2


s3war_bucket: 's3://LOCALDEV.vrsl.war'
api_war: api.LOCALDEV.war

backend_static_servers:
  server1:
    name: com.versal.web.s3-website-us-west-2.amazonaws.com
    dns:  com.versal.web.s3-website-us-west-2.amazonaws.com