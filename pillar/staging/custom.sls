#!yaml

# common staging custom.sls
# everything which mcp-staging does should go here, not in named groups

node:
  curl_auth:            '-u jenkins:jenkins123!'
  base_url:             http://artifactory.versal.com/libs-snapshot-local/com/versal
  bundle:               pb-express-site-SNAPSHOT.tar.bz2
  salt_bundle_dir:      staging/states/group/beta/role-nodejs
  server_bundle_dir:    /home/ubuntu/
  server_app_dir:       /home/ubuntu/pb-express-site-salt
