#!yaml

# Config settings for different server roles in this environment

server_roles:
  stack:
    role: 'stack'
    size: 'medium'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    instances:
      - {number: 1, region: 0, subregion: 0}
