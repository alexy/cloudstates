# global variables for use in this environment

# Example usage: pillar['environment'] == 'prod-dmv'

provisioner: salt-cloud

environment: prod

domain: dmv-prod.vrsl.net
salt_master: mcp-prod.vrsl.net
username: ubuntu

s3war_bucket: 's3://net.vrsl.net'
api_war:      api.dmv.war

minion:
  log_level: debug
  startup_states: sls
  sls_list:
    - common.services.mako
  grains:
    environment: prod