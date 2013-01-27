from boto import route53 as r53
import re
import time

IP_ADDRESS_REGEX = re.compile('^' + r'\.'.join([r'\d{1,3}'] * 4) + '$')

# Hardcoded AWS access keys for now, they are restricted to Route53
AWS_ACCESS_KEY_ID = 'AKIAIXKUMCDYTDE6MBBA'
AWS_SECRET_ACCESS_KEY = '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'

# Use a global connection for now, under the assumption that the programs
# using this module will only execute for a short time before terminating.
# If this is not the case, it would be better to wrap this in a class.
CONNECTION = \
    r53.connection.Route53Connection(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)

# Each module function must take the zone name as a parameter and look up the
# zone before doing any work. A future improvement would be to wrap these
# functions in a class that can be initialized with the zone to use.

def assign(zone_name, domain_name, value, ttl):
    """Create or update the DNS record for the given zone and domain to have
    the given values."""
    zone = CONNECTION.get_zone(zone_name)
    record = _find_record(zone, domain_name)

    # There's no way to change the type of an existing record in one operation.
    # Instead, we first DELETE if necessary and then CREATE a new record.
    change_set = r53.record.ResourceRecordSets(CONNECTION, zone.id)
    if record:
        change_set.add_change_record('DELETE', record)
    record_type = 'A' if _is_ip_address(value) else 'CNAME'
    change = change_set.add_change('CREATE', domain_name, record_type, ttl)
    change.add_value(value)
    change = change_set.commit()

    change_id = _get_change_id(change)
    while _get_change_state(CONNECTION.get_change(change_id)) == 'PENDING':
        time.sleep(10)

def delete(zone_name, domain_name):
    """Delete the DNS record for the given zone and domain."""
    zone = CONNECTION.get_zone(zone_name)
    record = _find_record(zone, domain_name)

    if record is not None:
        status = zone.delete_record(record)
        while status.update() == 'PENDING':
            time.sleep(10)

def query(zone_name, domain_name):
    """Return a dictionary containing the value and TTL assigned to the given
    zone and domain."""
    zone = CONNECTION.get_zone(zone_name)
    record = _find_record(zone, domain_name)

    if record is not None:
        if len(record.resource_records) == 1:
            return {'value': record.resource_records[0], 'ttl': int(record.ttl)}
        elif len(record.resource_records) > 1:
            raise Exception('Multiple values for domain: ' + domain_name)

def _find_record(zone, domain_name):
    records = zone.get_records()
    domain_name += '' if domain_name.endswith('.') else '.'
    matches = [record for record in records if record.name == domain_name]
    if len(matches) == 1:
        return matches[0]
    elif len(matches) > 1:
        raise Exception('Multiple records with name: ' + domain_name)

def _is_ip_address(s):
    return IP_ADDRESS_REGEX.match(s) is not None

def _get_change_info(change):
    return change.values()[0]['ChangeInfo']

def _get_change_id(change):
    return _get_change_info(change)['Id'].split('/')[-1]

def _get_change_state(change):
    return _get_change_info(change)['Status']
