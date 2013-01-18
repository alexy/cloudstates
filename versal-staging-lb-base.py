#creates versal-staging-lb-base-compiled.map

from mako.template import Template
import yaml
import inspect,os
basedirectory=os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe()))) # script directory
basename="versal-staging-lb-base"
#render mako|yaml
#fp_ = '/Users/mini/Versal/cloudstate/versal-staging.map'
fp_ = basedirectory+'/'+basename+'.map'
fp_compiled = basedirectory+'/'+basename+'-compiled.map'
temp_ = Template(open(fp_, 'r').read())
map_ = temp_.render()

#write to file:
#f = open('/Users/mini/Versal/cloudstate/versal-staging-compiled.map', "w")
f = open(fp_compiled, "w")
f.write(map_)
f.close()
