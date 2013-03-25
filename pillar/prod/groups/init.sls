#!mako|yaml

#group folder

<%
environment=grains['environment']
group=grains['group']
%>

domain: ${group}-${environment}.vrsl.net

# active groups -- the groups whose roles are expected to be present in update-dns
groups:
  - alpha
  - beta
  - dmv
