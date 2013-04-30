#!yaml

# prod group
# Config settings for servers in the dmv group in this environment

server_roles:
  mysqlcluster:
    role: 'mysqlcluster'
    size: 'medium'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    group: common
    instances:
      - {number: 2, region: 0, subregion: 0}
      - {number: 2, region: 0, subregion: 1}
      - {number: 1, region: 0, subregion: 2}

  log:
    role: 'log'
    size: 'medium'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    group: common
    instances:
      - {number: 1, region: 0, subregion: 0}
      - {number: 1, region: 0, subregion: 1}
