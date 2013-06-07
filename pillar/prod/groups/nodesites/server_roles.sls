#!yaml

# Config settings for servers in the group in this environment

server_roles:
  nodejs:
    role: 'nodejs'
    size: 'large'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    group: nodesites
    instances:
      - {number: 1, region: 0, subregion: 0}
      - {number: 1, region: 0, subregion: 1}

  # lb:
  #   role: 'lb'
  #   size: 'medium'
  #   tenant: 'single'
  #   dns: 'dynamic'
  #   os: Ubuntu
  #   os-version: 12_04_LTS
  #   group: nodesites
  #   instances: 
  #     - {number: 1, region: 0, subregion: 0}
  #     - {number: 1, region: 0, subregion: 1}