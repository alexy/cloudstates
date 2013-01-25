import route53
import unittest

class TestRoute53(unittest.TestCase):

    ZONE_NAME = 'vrsl.net'
    A_DOMAIN = 'mcp.vrsl.net'
    CNAME_DOMAIN = 'mcp-master.vrsl.net'
    A_VALUES = ['54.245.227.52', '54.245.227.55']
    CNAME_VALUES = [
        'ec2-54-245-227-52.us-west-2.compute.amazonaws.com',
        'ec2-54-245-227-55.us-west-2.compute.amazonaws.com'
    ]
    TTLS = [30 * n for n in range(1, 7)]

    def test_route53(self):
        print 'Deleting records that may not exist...'
        self.assertDeleted(self.A_DOMAIN)
        self.assertDeleted(self.CNAME_DOMAIN)

        print 'Creating new records...'
        self.assertAssigned(self.A_DOMAIN, self.A_VALUES[0], self.TTLS[0])
        self.assertAssigned(
            self.CNAME_DOMAIN,
            self.CNAME_VALUES[0],
            self.TTLS[1]
        )

        print 'Changing existing record values...'
        self.assertAssigned(self.A_DOMAIN, self.A_VALUES[1], self.TTLS[2])
        self.assertAssigned(
            self.CNAME_DOMAIN,
            self.CNAME_VALUES[1],
            self.TTLS[3]
        )

        print 'Changing existing record types...'
        self.assertAssigned(self.A_DOMAIN, self.CNAME_VALUES[0], self.TTLS[4])
        self.assertAssigned(self.CNAME_DOMAIN, self.A_VALUES[0], self.TTLS[5])

        print 'Deleting existing records...'
        self.assertDeleted(self.A_DOMAIN)
        self.assertDeleted(self.CNAME_DOMAIN)

    def assertAssigned(self, domain_name, value, ttl):
        route53.assign(self.ZONE_NAME, domain_name, value, ttl)
        info = route53.query(self.ZONE_NAME, domain_name)
        self.assertEqual(value, info['value'].rstrip('.'))
        self.assertEqual(ttl, info['ttl'])

    def assertDeleted(self, domain_name):
        route53.delete(self.ZONE_NAME, domain_name)
        info = route53.query(self.ZONE_NAME, domain_name)
        self.assertEqual(None, info)

if __name__ == '__main__':
    unittest.main()
