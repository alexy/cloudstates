#creates versal-staging-api-base-compiled.map

from mako.template import Template
import yaml
import os

#render mako|yaml
#fp_ = '/Users/mini/Versal/cloudstate/versal-staging.map'
fp_ = '/srv/cloudstate/versal-staging-api-base.map'
temp_ = Template(open(fp_, 'r').read())
map_ = temp_.render()

#write to file:
#f = open('/Users/mini/Versal/cloudstate/versal-staging-compiled.map', "w")
f = open('/srv/cloudstate/versal-staging-api-base-compiled.map', "w")
f.write(map_)
f.close()
