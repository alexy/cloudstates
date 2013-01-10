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
    - servers
