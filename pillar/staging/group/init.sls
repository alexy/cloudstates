#!mako|yaml

#group folder

<%
environment=grains['environment']
group=grains['group']
%>

domain: ${group}-${environment}.vrsl.net

groups:
  - hybrid
  - mandrill