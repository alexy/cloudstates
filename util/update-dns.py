#!/usr/bin/env python
# update-dns.py

import route53, uber

import sys, re, argparse

from yaml import load, dump
try:
    from yaml import CLoader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper


def load_running_status(status_file, provider, box_pattern):
  with open(status_file) as f:
  	y = load(f, Loader=Loader)
  if y.has_key(provider):
  	r = y[provider]
  else:
  	print >>sys.stderr, "no data for provider %s in live server status file!" % provider

  records = [(k, r[k]['public_ips'][0], r[k]['private_ips'][0]) for k in r.keys() if re.match(box_pattern, k)]

  role_instances = uber.generate_role_instances()

  r = {}
  for name,public_ip,private_ip in records:
  	r[name] = role_instances[name].copy()
  	r[name]['public_ip']  = public_ip
  	r[name]['private_ip'] = private_ip
  return r


def query_running_dns(records, zone):
	for name, ips in records:
		assigned = route53.query(zone, name)
		print >>sys.stderr, "%s => " % name, assigned
		if not assigned:
		  just_assigned = route53.assign(zone, name, ips[0], 60)
		  check_assigned = route53.query(zone, name)
		  print >>sys.stderr, "just assigned %s => " % name, just_assigned, check_assigned


def main():
  parser = argparse.ArgumentParser(description='Versal DNS updater')
  parser.add_argument('--provider', default="aws", help="cloud provider id recognized by libcloud")
  parser.add_argument('--domain', default="vrsl.net", help="domain which must be contained in the instances names")
  parser.add_argument('--env', default='staging', help="environment which must be contained in the instance names")
  parser.add_argument('status_file', help="the salt-cloud -Q yaml output file")
  arg = parser.parse_args()

  box_pattern = ".*%s.%s" % (arg.env, arg.domain)

  print >>sys.stderr, "updating DNS records of the hosts on %s matching %s" % (arg.provider, box_pattern)

  records = load_running_status(arg.status_file, arg.provider, box_pattern)
  print >>sys.stderr, "working with records ", records

  #query_running_dns(records, arg.domain)

main()
