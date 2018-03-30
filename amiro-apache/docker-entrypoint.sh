#!/bin/bash
set -e

/etc/init.d/apache2 start
rsync -a /opt/amiro-apache /var/www

exec $@
