import os

def h():
    print os.path.abspath( __file__ )

import inspect, os
print inspect.getfile(inspect.currentframe()) # script filename (usually with path)
print os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe()))) # script directory


import sys, os

print 'sys.argv[0] =', sys.argv[0]             
pathname = os.path.dirname(sys.argv[0])        
print 'path =', pathname
print 'full path =', os.path.abspath(pathname)