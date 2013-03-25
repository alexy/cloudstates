#!yaml

# dmv staging group
# Config settings for servers in the dmv group in this environment

server_roles:
  api:
    role: 'api'
    size: 'small'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    instances:
      - {number: 1, region: 0, subregion: 1}
