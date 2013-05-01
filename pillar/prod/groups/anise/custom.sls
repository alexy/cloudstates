#!mako|yaml

<% 
  saltmine_tomcat7_homedir  = '/usr/share/tomcat7'
  saltmine_tomcat7_webappsdir = '/var/lib/tomcat7/webapps/'

  environment               = grains['environment']
  group                     = grains['group'] if 'group' in grains else None
  roles                     = grains['roles'][0] if 'roles' in grains else None

  war_customname            = 'platform2.war'
  dotversal_customname      = 'versal-platform2'
  dotversal_s3name          = 'dotversal-platform2'
%>

s3war_bucket:    's3://net.vrsl.anise.prod'
saltmine_tomcat7_webappsdir: ${saltmine_tomcat7_webappsdir}


# NB have to specify all keys, as the whole is overwritten!
war:
    api:
      source:    ${war_customname}_usr-share-tomcat7-webapps_${roles}_${group}_${environment}
      target:    ${saltmine_tomcat7_homedir}/${war_customname}
      dotversal_source: ${dotversal_s3name}_${roles}_${group}_${environment}
      dotversal_target: ${saltmine_tomcat7_homedir}/${dotversal_customname} #name to manage
      context_xml_source: context.xml_var-lib-tomcat7-conf_${roles}_${group}_${environment}
      context_xml_target: '/var/lib/tomcat7/conf/context.xml'
      db_url:    aphid-region-0-0-common-prod.vrsl.net/platform2
      db_user:   platform2
      db_pwd: 'k&9QQ#J6~#J6~4uS'

api_key: SECRET

#TODO clean this up. arg why is this required? shouldn't be here.
s3cdn_bucket:   'com.versal.beta.assets.staging'
/var/lib/tomcat7/conf/server.xml