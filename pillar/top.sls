#https://salt.readthedocs.org/en/latest/topics/pillar/index.html
#pillar data is available GLOBALLY to all scripts and minions!
#to sync pillar data with minions manually, do:
# salt '*' saltutil.refresh_pillar

#To view Pillar data:
# salt '*' pillar.data

#To target minions based on pillar data...
# salt -I 'somekey:specialvalue' test.ping

base:
  '*':
    - packagenames
    - server_names
    - static_ips
    - region_mapping
    - instance_kinds
    - cloud_images

localdev:
  'environment:localdev':
    - match: grain  
    - env_globals

dev:
  'environment:dev':
    - match: grain  
    - env_globals

staging:
  'environment:staging':
    - match: grain
    - env_globals
    - server_roles
    - server_status
    - salt_cloud    

prod:
  'environment:prod':
    - match: grain  
    - env_globals


