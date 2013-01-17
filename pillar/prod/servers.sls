# prod servers

api:
	- auto-managed: False
	- instances:
	  - ec2-54-245-225-243.us-west-2.compute.amazonaws.com:8080
	  - ec2-54-245-225-244.us-west-2.compute.amazonaws.com:8080
	  - ec2-54-245-225-245.us-west-2.compute.amazonaws.com:8080
	  - ec2-54-245-225-246.us-west-2.compute.amazonaws.com:8080

lb:
	- auto-managed: False
	- instances:
	  - lb1.vrsl.net
	  - lb2.vrsl.net

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
