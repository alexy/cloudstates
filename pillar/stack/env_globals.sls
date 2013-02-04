# TODO mako-ficate the env through domain, grain
# global variables for use in this environment

# Example usage: pillar['environment'] == 'stack'

environment: stack

domain: stack.vrsl.net

salt_master: mcp-staging.vrsl.net

minion:
  log_level: debug
  startup_states: sls
  sls_list:
    - common.services.mako
  grains:
    environment: stack

