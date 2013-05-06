#!yaml

# anise prod group
# Config settings for servers in the anise group in this environment

server_roles:
  api:
    role: 'api'
    size: 'medium'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    group: anise
    instances:
      - {number: 2, region: 0, subregion: 0}
      - {number: 2, region: 0, subregion: 1}

  lb:
    role: 'lb'
    size: 'medium'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    group: anise
    instances: 
      - {number: 1, region: 0, subregion: 0}
      - {number: 1, region: 0, subregion: 1}

  static:
    role: 'static'
    size: 'medium'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    group: anise
    instances: 
      - {number: 1, region: 0, subregion: 0}
      - {number: 1, region: 0, subregion: 1}
