#!yaml

# Any keys listed here will overwrite prior items 'included'.
# This is a good way to overwrite defaults.

include:
  - common.env_globals
  - localdev.salt_cloud_live_instances
  - localdev.server_roles
  - localdev.openstack

provisioner: vagrant
domain: localhost
salt_master: 10.0.2.2

minion:
  log_level: debug
  startup_states: sls
  sls_list:
    - common.services.mako
  grains:
    environment: localdev