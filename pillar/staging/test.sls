from yaml import load, dump
try:
    from yaml import CLoader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper
import inspect,os

from copy import deepcopy

import sys, argparse

def load_pillar():
  basedirectory = '/srv/cloudstate/pillar/'
 # basedirectory = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))+'/pillar/'
  environment   = 'staging'
  envdirectory  = basedirectory+environment+'/'

  #envdirectory= os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
  pillar_env_files    = ['region_mapping', 'server_names', 'salt_cloud_live_instances']

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

p = load_pillar()
server_names = p['server_names']
server_salt_cloud = p['aws']
