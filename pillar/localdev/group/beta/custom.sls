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