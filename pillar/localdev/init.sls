#!mako|yaml

# This file should ONLY include 'include' files. To set custom keys, 
# include them in the custom.sls file. Do NOT include keys in this file.
# The pillar dictionary is compiled in the order that they appear in this list.
# Newer keys OVERWRITE older keys.

include:
  - common.env_globals
  - ${grains['environment']}.salt_cloud_live_instances
  - ${grains['environment']}.server_roles
  - ${grains['environment']}.custom

