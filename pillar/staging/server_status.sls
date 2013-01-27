#!mako|yaml

# When a server is started, the server is added to servers_status. If a server is terminated, 
# it is removed. If a server is 'stopped', it shows as state: STOPPED

<%!

from yaml import load, dump
try:
    from yaml import CLoader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper
import inspect,os

from copy import deepcopy

import sys, argparse


def load_pillar():
  # basedirectory = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))+'/pillar/'
  # environment   = 'staging'
  # envdirectory  = basedirectory+environment+'/'

  envdirectory= os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
  pillar_env_files    = ['server_names', 'salt_cloud_live_instances']

  pillar_files = []

  for filename in pillar_env_files:
    pillar_files.append(envdirectory + filename + '.sls')

  p = {}

  for pathname in pillar_files:  
    with file(pathname, 'r') as f:
      d_ = load(f, Loader=Loader)
      for k in d_:
        if p.has_key(k):
          # TODO barf profusely
          print "KEY CONFLICT on '%s' reading %s" % (k, pathname)
        else:
          p[k] = d_[k]

  return p
  
%>

<%

def get_role(server_search_name, server_names_local):
  '''
  Searches the passed python object for an entry with the designated name.
  If it finds the name, it returns the role for that name.
  '''
  for role_name in server_names_local:
    for server_name in server_names_local[role_name]:
      if server_name == server_search_name:
        return role_name
      
  return 'none'  
  #TODO print error message. raise exception

def generate_aws_cname(ip_address, region='us-west-2', dns_type='public_dns'):
  '''
  Given the ip address of a minion, turn that into a aws cname.
  This function will only be called if the server region is an aws region.
  You can pass in a specific region, and you can also specify either `public_dns` 
  or `private_dns` to specify the type of dns entry to create. 

  example return values:
  ip-10-252-148-30.us-west-2.compute.internal
  ec2-54-245-237-177.us-west-2.compute.amazonaws.com
  '''
  if dns_type == 'public_dns':
    temp_cname = 'ec2-'+ip_address.replace('.','-')+'.'+region+'.compute.amazonaws.com'
    return temp_cname
  elif dns_type == 'private_dns':
    temp_cname = 'ip-'+ip_address.replace('.','-')+'.'+region+'.compute.internal'
    return temp_cname
  else:
    return 'error. unknown dns_type.' 
  #TODO print error message. raise exception

def get_region_provider(region, subregion):
  '''
  Given a `region` and `subregion`, this function will return the provider type.
  '''
  return pillar["region_mapping"][region][subregion]["provider"]

def get_aws_location(region, subregion):
  '''
  Given a `region` and `subregion`, this function will return the name of the aws location.
  '''
  return pillar["region_mapping"][region][subregion]["location"]

#format:
#- name: apple-region-0-1-staging.vrsl.net
#  id: i-32141ja
#  public_dns: 192.168.1.1
#  private_dns: 127.0.0.1
#  state: RUNNING
%>


#
server_status:
% for server in server_salt_cloud:
  <%
  server_names = p['server_names']
  server_salt_cloud = p['aws']
  serverparams = server['name'].split('-') # servername / region / subregion+domain
  param_region = serverparams[2] # region
  param_subregion = serverparams[3]
  ##param_subregion = serverparams[2].split('.')[0] # subregion
  %>

  - name: ${server['name']}
    roles: ${get_role(server['name'],server_names)}
  % if get_region_provider(param_region, param_subregion) == 'aws':
    <%
    aws_region = get_aws_location(param_region, param_subregion)
    %>
    public_dns: ${generate_aws_cname(server['public_dns'],aws_region)}
    private_dns: ${generate_aws_cname(server['private_dns'],aws_region, 'private_dns')}
  % else: # everyone but aws
    public_dns: ${server['public_dns']}
    private_dns: ${server['private_dns']}
  % endif
    state: ${server['state']}
% endfor