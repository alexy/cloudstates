#!yaml

# dmv staging group
# Config settings for servers in the dmv group in this environment

server_roles:
  api:
    role: api
    size: medium
    tenant: single
    dns: dynamic
    os: Ubuntu
    os-version: 12_04_LTS
    group: beta
    instances:
      - {number: 5, region: 0, subregion: 0}
      - {number: 5, region: 0, subregion: 1}


  lb:
    role: lb
    size: small
    tenant: single
    dns: dynamic
    os: Ubuntu
    os-version: 12_04_LTS
    group: beta
    instances: 
      - {number: 1, region: 0, subregion: 0}

