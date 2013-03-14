from yaml import load
try:
    from yaml import CLoader as Loader
except ImportError:
    from yaml import Loader
from sys import stderr

from mako.template import Template

def load_mako_yaml(pathname, environment, group=None):
  try:
    with open(pathname, 'r') as f:
      m_ = Template(f.read()).render(grains={'environment': environment, 'group': group})
      d_ = load(m_, Loader=Loader)
      return d_
  except:
    print >>stderr, "COULD NOT LOAD %s into pillar" % pathname
    return None


def base_dir():
  return '/srv/cloudstate/pillar/'

# TODO replace '+', '/' by file system concat with separator
def common_dir():
  return base_dir() + 'common/'

def environment_dir(environment):
  return base_dir() + environment + '/'

def groups_top_dir(environment):
  return environment_dir(environment) + 'group/'

def groups_top_init(environment):
  return groups_top_dir(environment) + 'init.sls'

def group_dir(environment, group):
  return groups_top_dir(environment) + group + '/'

def load_pillar(environment, group, basedir=base_dir(), 
    common_files=['env_globals','cloud_images','instance_kinds','region_mapping','server_names'], 
    environment_files=['init','server_roles','custom'], 
    group_files=['init','server_roles','custom']):
  commondir = common_dir()
  envdir    = environment_dir(environment)
  groupdir  = group_dir(environment, group)

  pillar_files = []

  # some pillars are in common
  for filename in common_files:
    pillar_files.append(commondir + filename + '.sls')

  # some pillars are in the environment
  for filename in environment_files:
    pillar_files.append(envdir    + filename + '.sls')

  # some pillars are in the group
  for filename in group_files:
    pillar_files.append(groupdir  + filename + '.sls')

  p = {}

  for pathname in pillar_files:
    d_ = load_mako_yaml(pathname, environment, group)
    if d_:
      for k in d_:
        if k in p:
          # TODO log to rsyslog for salt -- set it up
          print >>stderr, "KEY OVERRIDE on '%s' reading %s" % (k, pathname)
        p[k] = d_[k]
      print >>stderr, "loaded %s into pillar" % pathname
  
  if 'environment' not in p:
    print >>stderr, "pillar had no environment set"
  elif p['environment'] != environment:
    print >>stderr, "pillar environment %s DID NOT MATCH given %s" % (p['environment'], environment)
  p['environment'] = environment
  p['group'] = group
  return p