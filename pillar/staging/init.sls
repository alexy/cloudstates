#!yaml

# defaults for servers without group grains set

include:
  - common.env_globals
  - staging.server_roles

s3war_bucket: 's3://net.vrsl.war'
api_war:       api.staging.war