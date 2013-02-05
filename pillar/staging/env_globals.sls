# global variables for use in this environment

# Example usage: pillar['environment'] == 'staging'

provisioner: salt-cloud

environment: staging

domain: staging.vrsl.net

salt_master: mcp-staging.vrsl.net 
username: ubuntu
minion:
  log_level: debug
  startup_states: sls
  sls_list:
    - common.services.mako
  grains:
    environment: staging

