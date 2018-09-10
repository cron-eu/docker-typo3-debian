#!/usr/bin/env /bin/bash
set -ex

##
# Configure the apache webroot to be /var/www/html/web
#

settings_file="/etc/apache2/sites-enabled/000-default.conf"

# replace the DocumentRoot accordingly
sed -i -r "1,/DocumentRoot /s/DocumentRoot .+?/DocumentRoot \/var\/www\/html\/web/g" $settings_file
