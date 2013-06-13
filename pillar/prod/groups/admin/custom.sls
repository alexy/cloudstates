#!mako|yaml

<% 
  environment               = grains['environment']
  group                     = grains['group'] if 'group' in grains else None
  roles                     = grains['roles'][0] if 'roles' in grains else None
%>


s3.keyid: AKIAJ3U5UM53DYPMA2CA
s3.key: sn8n4KlxfVyZfKXnkIeSd/exnWKmu9p46hQrZwrh
