#!yaml

# Config settings for different server roles in this environment

# api1-staging.vrsl.net
# Example usage:
# pillar["server_roles"]["api"]

server_roles:
  api:
    role: 'api'
    size: 'medium_cpu'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    instances:
      - {number: 1, region: 0, subregion: 0}
      - {number: 1, region: 0, subregion: 1}

  lb:
    role: 'lb'
    size: 'small'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    instances: 
      - {number: 1, region: 0, subregion: 0}
