#!mako|yaml

# When a server is started, the server is added to servers_status. If a server is terminated, 
# it is removed. If a server is 'stopped', it shows as state: STOPPED

<$
# load the pillar containing the server data outputted by salt-cloud
import pillar_loader
pillar_load["staging/salt-cloud-output.sls"]

def get_role(server_search_name, server_names_local):
  '''
  Searches the passed python object for an entry with the designated name.
  If it finds the name, it returns the role for that name.
  '''
  #serverparams = servername.split('-')

  for role_name in server_names_local:
    for server_name in server_names_local[role_name]:
      if server_name == server_search_name:
        return role_name
      
  return 'none'  

$>

#format:
#- name: apple-0-1.vrsl.net
#  id: i-32141ja
#  public_dns: 192.168.1.1
#  private_dns: 127.0.0.1
#  state: RUNNING

server_salt_cloud = pillar['salt-cloud-output']
server_names = pillar['server_names']

server_status:
  % for server in server_salt_cloud:
  - name: ${server['name']}
    roles: ${get_role(server['name'],server_names)}
    public_dns: ${server[public_dns]}
    private_dns: ${server[private_dns]}
    state: ${server[state]}
    ${serverparams[1]} # region
  % endfor