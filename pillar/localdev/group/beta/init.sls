#!yaml

# This file should ONLY include 'include' files. To set custom keys, 
# include them in a custom.sls file. Do NOT include keys in this file.
# The pillar dictionary is compiled in the order that they appear in this list.
# Newer keys OVERWRITE older keys.

include:
  - staging
  - staging.group.beta.server_roles
  - staging.group.beta.custom
