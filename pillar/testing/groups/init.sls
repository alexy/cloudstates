#!yaml

#group folder

<%
environment=grains['environment']
group=grains['group']
%>

domain: ${group}-${environment}.vrsl.net

# active groups that will be managed by update-dns
groups:
  - beta
  - platform2