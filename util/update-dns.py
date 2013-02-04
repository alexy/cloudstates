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

  records = [(k, r[k]['public_ips'][0], r[k]['private_ips'][0]) for k in r.keys() if re.match(box_pattern, k) and r[k]['state'] == 'RUNNING']

  role_instances = uber.generate_role_instances()

  r = {}
  for name,public_ip,private_ip in records:
  	r[name] = role_instances[name].copy()
  	r[name]['public_ip']  = public_ip
  	r[name]['private_ip'] = private_ip
  return r


def query_running_dns(records, zone):
  for rec in records:
    assigned = route53.query(zone, rec)
    print >>sys.stderr, "%s => " % rec, assigned


# TODO this only works for amazon
def aws_public_dns_from_ip(ip, location):
	# ec2-54-245-178-203.us-west-2.compute.amazonaws.com
	return "ec2-%s.%s.compute.amazonaws.com" % (re.sub('\.','-',ip), location)

def ensure_running_dns(records, zone):
  for rec in records:
	# TODO place the default TTL somewhere central
	host = records[rec]
	route53.assign(zone, rec, aws_public_dns_from_ip(host['public_ip'],host['location']), 60)
	assigned = route53.query(zone, rec)
	print >>sys.stderr, "just assigned %s => " % rec, assigned


def __main__():
  parser = argparse.ArgumentParser(description='Versal DNS updater')
  parser.add_argument('--provider', default="aws", help="cloud provider id recognized by libcloud")
  parser.add_argument('--domain', default="vrsl.net", help="domain which must be contained in the instances names")
  parser.add_argument('--env', default='staging', help="environment which must be contained in the instance names")
  parser.add_argument('status_file', help="the salt-cloud -Q yaml output file")
  parser.add_argument('-e', '--ensure', action="store_true", help="when supplied, actually assign everything")
  parser.add_argument('-q', '--query',  action="store_true", help="when supplied, query DNS for the running instances")
  arg = parser.parse_args()

  box_pattern = ".*%s.%s" % (arg.env, arg.domain)

  print >>sys.stderr, "updating DNS records of the hosts on %s matching %s" % (arg.provider, box_pattern)

  records = load_running_status(arg.status_file, arg.provider, box_pattern)
  print >>sys.stderr, "working with records ", records

  if arg.query:
  	query_running_dns(records, arg.domain)

  if arg.ensure:
  	ensure_running_dns(records, arg.domain)


#if __name__ == __main__:
__main__()
