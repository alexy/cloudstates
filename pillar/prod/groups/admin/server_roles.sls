#!yaml

# Config settings for servers in the group in this environment

server_roles:
  map:
    role: 'mcp'
    size: 'medium'
    tenant: 'single'
    dns: 'dynamic'
    os: Ubuntu
    os-version: 12_04_LTS
    group: admin
    instances:
      - {number: 1, region: 0, subregion: 0}

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