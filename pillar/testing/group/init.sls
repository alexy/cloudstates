#!yaml

#group folder

<%
environment=grains['environment']
group=grains['group']
%>

domain: ${group}-${environment}.vrsl.net
# active groups
groups:
  - beta