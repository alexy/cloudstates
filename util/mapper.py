#!/usr/bin/env python
from yaml import load, dump
try:
    from yaml import CLoader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper
import inspect,os

from copy import deepcopy

import sys, argparse

from load_pillar import load_pillar, load_mako_yaml, groups_top_init

def name_instance_kind(env, instance_kind, region_index, subregion_index):
  return "%s_%s_region-%d-%d" % (env, instance_kind, region_index, subregion_index)

def name_instance(name, region_index, subregion_index, domain):
  return "%s-region-%d-%d-%s" % (name, region_index, subregion_index, domain)

def generate_cloud_profiles(p, envs, os_name="Ubuntu", os_version="12_04_LTS"):
  r = {}
  for env in envs:
    for instance_kind in p['instance_kinds']:
      for region_index, region in enumerate(p['region_mapping']):
        for subregion_index, subregion in enumerate(region):
          instance_key   = name_instance_kind(env, instance_kind, region_index, subregion_index)

          provider       = subregion['provider']
          location       = subregion['location']
          image          = p['cloud_images'][provider][os_name][os_version][location]
          instance_size  = p['instance_kinds'][instance_kind][provider]

          minion = deepcopy(p['minion']) # NB otherwise pyyaml created &id001 reference 
          # to the subarray in the first map,
          # and referenced it as *id001 in every subsequent map!

          minion['master'] = p['salt_master']

          instance_props           = subregion.copy() # TODO fields are only for AWS
          instance_props['image']  = image
          instance_props['size']   = instance_size
  # salt-cloud reverted John's change, not using script, falling on bootstrap for now
  #        instance_props['script'] = os_name # TODO map Ubuntu to ubuntu and rename os back to the latter
          instance_props['minion'] = minion

          r[instance_key] = instance_props

  return r


def generate_role(p, role):
  server_group = p['server_roles'][role]
  server_names = p['server_names'][role]
  r = {}
  instance_count = 0
  for instance in server_group['instances']:
    environment     = p['environment']
    instance_size   = server_group['size']
    region_index    = instance['region']
    subregion_index = instance['subregion']

    instance_kind = name_instance_kind(environment, instance_size, region_index, subregion_index)

    instance_list = []

    for i in range(instance['number']):
      instance_name = name_instance(server_names[instance_count], region_index, subregion_index, p['domain'])

      instance_props = {
        'master': p['salt_master'],
        'grains': {
          'group': p['group'],
          'roles': [server_group['role']]
          }, 
        'environment': environment
      }

      instance_list.append({instance_name: instance_props})

      instance_count += 1

    r[instance_kind] = instance_list

  return r


def generate_roles(pillar, rolesOpt=None):
  roles = rolesOpt if rolesOpt else pillar['server_roles'].keys()
  r = {}
  for role in roles:
    r[role] = generate_role(pillar, role)
  return r


# this function is callable from update-dns right away
def generate_group_instances(pillarOpt=None, rolesOpt=None, environment=None, group=None):
  pillar = pillarOpt if pillarOpt else load_pillar(environment=environment, group=group)
  role_names = rolesOpt if rolesOpt else pillar['server_roles'].keys()
  roles      = generate_roles(pillar, role_names)
  profiles   = generate_cloud_profiles(pillar, [pillar['environment']])

  r = {}
  for role in roles:
    for kind in roles[role]:
      location = profiles[kind]['location']
      for instance in roles[role][kind]:
        instance_name  = instance.keys()[0]
        instance_props = {'location': location, 'roles': role}
        # TODO if we have multiple roles per instance,
        # the instance name key may have been already present
        # and we'd need to 
        # (1) validate location equality and 
        # (2) merge the roles into an array
        r[instance_name] = instance_props
  return r

def generate_environment_instances(environment):
  # TODO error well if the key is missing!
  group_init_path = groups_top_init(environment) 
  group_init = load_mako_yaml(group_init_path, environment)
  print group_init
  groups = group_init['groups']
  combined = {}
  for group in groups:
    g = generate_group_instances(environment=environment, group=group)
    for instance_name in g:
      if instance_name in combined:
        print >>stderr, "INSTANCE NAME OVERRIDE in environment %, group %s" % (environment, group)
      combined[instance_name] = g[instance_name]
  return combined

def __main__():

  parser = argparse.ArgumentParser(description='Versal salt-cloud YAML generator')
  parser.add_argument('-P', '--profiles',     action="store_true", help="generate cloud.profiles")
  parser.add_argument('-R', '--allroles',     action="store_true", help="generate all roles for inspection")
  parser.add_argument('-I', '--allinstances', action="store_true", help="generate all instances for DNS and running status")
  parser.add_argument('-r', '--role',                              help="generate a specific role from the list of all roles")
  parser.add_argument('-e', '--environment',  default='staging',   help="use a given environment")
  parser.add_argument('-g', '--group',        default='test',      help="use a given group")

  arg = parser.parse_args()

  p = load_pillar(environment=arg.environment, group=arg.group)
  #print p

  print >> sys.stderr, "generating salt-cloud configuration for environment: %s, group: %s" % (arg.environment, arg.group)

  if arg.profiles:
    print >>sys.stderr, "generating cloud.profiles"
    r = generate_cloud_profiles(p, [arg.environment])
    # TODO we need to make this a function,
    # dump to a stream,
    # and possibly set default_flow_style=False 'globally'
    print dump(r, default_flow_style=False)
  elif arg.role:
    print >>sys.stderr, "generating the %s roles map" % arg.role
    r = generate_role(p, arg.role)
    print dump(r, default_flow_style=False)
  elif arg.allroles:
    print >>sys.stderr, "generating all roles"
    all_roles = p['server_roles'].keys()
    r = generate_roles(p, all_roles)
    print dump(r, default_flow_style=False)
  elif arg.allinstances:
    print >>sys.stderr, "generating all instances"
    r = generate_role_instances(p)
    print dump(r, default_flow_style=False)
  else:
    print "you want something which doesn't seem to exist, eh?"


if __name__ == '__main__':
  __main__()






