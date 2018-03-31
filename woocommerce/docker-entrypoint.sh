#!/bin/bash
set -e

rsync -a /opt/woocommerce /var/www

cd /var/www/woocommerce

wp plugin --allow-root activate woocommerce
wp plugin --allow-root activate modulbank

exec $@
