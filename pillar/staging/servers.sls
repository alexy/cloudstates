# staging servers pillar

domain: staging.vrsl.net
salt_master: mcp-staging.vrsl.net
environment: staging

# api1-staging.vrsl.net


api:
  role: 'api'
  size: 'medium'
  tenant: 'single'
  dns: 'dynamic'
  instances:
    - {number: 2, provider: 'aws', region: 'west-2b'}
    - {number: 2, provider: 'aws', region: 'west-2c'}


lb:
  role: 'lb'
  size: 'small'
  tenant: 'single'
  dns: 'static'
  instances: 
    - {number: 1, provider: 'aws', region: 'west-2b'}
    - {number: 1, provider: 'aws', region: 'west-2c'}

api_names:
  - apple
  - banana
  - cherry
  - date
  - etrog
  - fig
  - grape
  - huckleberry
  - indianalmond
  - jasmine
  - kiwi
  - lemon
  - melon
  - nectarine
  - orange
  - plum
  - quinze
  - raspberry
  - strawberry
  - tangerine
  - ugli
  - vanilla
  - watermelon
  - xigua
  - yumberry
  - zucchini

lb_names:
  - agnon
  - beckett
  - camus
  - deledda
  - elytis
  - faulkner
  - garcia
  - hemingway
  - italia
  - jensen
  - kipling
  - lewis

lb_static_ips:
  - 54.245.225.145
  - 54.245.225.243
  - 54.245.225.243
  - 54.245.225.243
  - 54.245.225.243
  - 54.245.225.243
  - 54.245.225.243
  - 54.245.225.243
  - 54.245.225.243
  - 54.245.225.243
  - 54.245.225.243
  - 54.245.225.243
  - 54.245.225.243
  - 54.245.225.243
  - 54.245.225.243


# uni:
#   - 192.168.1.4
#   - 192.168.1.5