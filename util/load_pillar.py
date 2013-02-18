from yaml import load
try:
    from yaml import CLoader as Loader
except ImportError:
    from yaml import Loader
from sys import stderr

from mako.template import Template

def load_pillar(environment, group, basedir='/srv/cloudstate/pillar/', 
    common_files=['env_globals','cloud_images','instance_kinds','region_mapping','server_names'], 
    environment_files=['init','server_roles','custom'], 
    group_files=['init','server_roles','custom']):
  commondir = basedir + 'common/'
  envdir    = basedir + environment + '/'
  groupdir  = envdir  + 'group/' + group + '/'

  # setting up mako

  grains = {'environment': environment, 'group': group}

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
    try:  
      with file(pathname, 'r') as f:
        m_ = Template(f.read()).render(grains=grains)
        d_ = load(m_, Loader=Loader)
        for k in d_:
          if k in p:
            # TODO log to rsyslog for salt -- set it up
            print >>stderr, "KEY OVERRIDE on '%s' reading %s" % (k, pathname)
          else:
            p[k] = d_[k]
        print >>stderr, "loaded %s into pillar" % pathname
    except:
      print >>stderr, "could not load %s into pillar" % pathname

  if 'environment' not in p:
    print >>stderr, "pillar had no environment set"
  elif p['environment'] != environment:
    print >>stderr, "pillar environment %s did not match given %s" % (p['environment'], environment)
  p['environment'] = environment
  p['group'] = group
  return p