#!yaml

# Config settings for servers in the mandrill group in this environment

server_roles:
  api:
    role: 'api'
    size: 'medium_cpu'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    group: mandrill
    instances:
      - {number: 1, region: 0, subregion: 0}
