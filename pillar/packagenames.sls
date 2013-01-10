#Handle package name differences...
#In the sls files, load this data by using this:
# name: {{ pillar['git'] }}

{% if grains['os'] == 'RedHat' %}
apache: httpd
#git: git
{% elif grains['os'] == 'Debian' %}
apache: apache2
#git: git-core
{% endif %}
