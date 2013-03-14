#!yaml

war:
    api:  
      source: api.testing.war
      target: api.war
    auth:
      source: frontdoor.testing.war
      target: frontdoor.war

backend_static_servers:
  server1:
    name: com.versal.testbeta.s3-website-us-west-2.amazonaws.com
    dns:  com.versal.testbeta.s3-website-us-west-2.amazonaws.com
