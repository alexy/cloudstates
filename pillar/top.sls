#https://salt.readthedocs.org/en/latest/topics/pillar/index.html
#pillar data is available GLOBALLY to all scripts and minions!
#to sync pillar data with minions manually, do:
# salt '*' saltutil.refresh_pillar

#To view Pillar data:
# salt '*' pillar.data

#To target minions based on pillar data...
# salt -I 'somekey:specialvalue' test.ping

#Handle package name differences...
#In the sls files, load this data by using this:
# name: {{ pillar['git'] }}

{% if grains['os'] == 'RedHat' %}
apache: httpd
git: git
{% elif grains['os'] == 'Debian' %}
apache: apache2
git: git-core
{% endif %}

api:
  - ec2-54-245-225-243.us-west-2.compute.amazonaws.com:8080
  # - api2.vrsl.net
  # - api3.vrsl.net
  # - api4.vrsl.net

# lb:
#   - lb1.vrsl.net
#   - lb2.vrsl.net

# log:
#   - log1.vrsl.net

# db:
#   - db1.vrsl.net
#   - db2.vrsl.net
#   - db3.vrsl.net
#   - db4.vrsl.net

# List of default TCP ports to open in iptables:
#accept_tcp_ports:
#  - 80
#  - 22

# List of all daemons which should be enabled at boot:
# daemons:
#   - syslog-ng
#   - network
#   - sshd
#   - ntpd
#   - crond
#   - iptables
#   - salt-minion

# List of users allowed to log in with ssh:
# allowed_users:
#   - myunprivilegeduser
