# global variables for use in this environment

# Example usage (mako): localdev = pillar.get('localdev')

provisioner: vagrant

environment: localdev

domain: localhost
salt_master: 10.0.2.2
username: vagrant

minion:
  log_level: debug
  startup_states: sls
  sls_list:
    - common.services.mako
  grains:
    environment: localdev