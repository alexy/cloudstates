#!yaml

war:
    api:  
      source: api.prod.war
      target: api.war
    auth:
      source: frontdoor.prod.war
      target: frontdoor.war

backend_static_servers:
  server1:
    name: com.versal.beta.s3-website-us-west-2.amazonaws.com
    dns:  com.versal.beta.s3-website-us-west-2.amazonaws.com
