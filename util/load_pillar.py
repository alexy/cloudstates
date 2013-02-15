from yaml import load
try:
    from yaml import CLoader as Loader
except ImportError:
    from yaml import Loader

def load_pillar(environment, group, basedir='/srv/cloudstate/pillar/', 
    common_files=['env_globals','cloud_images','instance_kinds','region_mapping','server_names'], 
    environment_files=['server_roles','custom'], 
    group_files=['server_roles','custom']):
  commondir = basedir + 'common/'
  envdir    = basedir + environment + '/'
  groupdir  = envdir  + group       + '/'

  pillar_files = []

  # some pillars are in common
  for filename in common_files:
    pillar_files.append(common + filename + '.sls')

  # some pillars are in an environment
  for filename in environment_files:
    pillar_files.append(envdir + filename + '.sls')

  # some pillars are in an environment
  for filename in environment_files:
    pillar_files.append(envdir + filename + '.sls')

  p = {}

  for pathname in pillar_files:
    try:  
      with file(pathname, 'r') as f:
        d_ = load(f, Loader=Loader)
        for k in d_:
          if p.has_key(k):
            # TODO log to rsyslog for salt -- set it up
            print >>sys.stderr, "KEY OVERRIDE on '%s' reading %s" % (k, pathname)
          else:
            p[k] = d_[k]
    except:

  return p