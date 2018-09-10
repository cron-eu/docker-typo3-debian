#!/usr/bin/env /bin/bash

if ! [ -f "/var/www/html/composer.json" ] ; then
  echo "provisioning /var/www from /var/www-orig .."
  rsync -a /var/www-orig/ /var/www/
  echo "done!"
fi

exec apachectl -D FOREGROUND
