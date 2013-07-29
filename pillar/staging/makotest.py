from mako import exceptions

try:
    template = lookup.get_template('./server_status.sls')
    print template.render()
except:
    print exceptions.text_error_template().render()
