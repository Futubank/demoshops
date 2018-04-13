#!/bin/bash
set -e

cp -f /dist/install.php /var/www/umicms/

exec $@
