#!yaml

# Config settings for servers in the group in this environment

server_roles:
  transcode:
    role: 'transcode'
    size: 'small'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    group: transcode
    instances:
      - {number: 1, region: 0, subregion: 0}
      - {number: 1, region: 0, subregion: 1}

