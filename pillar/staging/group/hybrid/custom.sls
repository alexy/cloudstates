#!yaml

group:         hybrid
s3war_bucket: 's3://net.vrsl.war'
api_war:       api.staging.war

backend_static_servers:
  server1:
    name: com.versal.hybrid.s3-website-us-west-2.amazonaws.com
    dns:  com.versal.hybrid.s3-website-us-west-2.amazonaws.com