#!/bin/bash
set -ex

rsync -a /opt/woocommerce /var/www

cd /var/www/woocommerce

wp core install --allow-root --url="http://172.100.0.15:8000" --title="Woocommerce Test Merchant" --admin_user=admin --admin_email=user@example.com --admin_password=123123 --skip-email
wp plugin --allow-root activate woocommerce
#wp plugin --allow-root activate modulbank

wp language core install ru_RU --allow-root
wp language core activate ru_RU --allow-root

# Disable FTP/SFTP/etc in uploading.
wp config set --type=constant FS_METHOD direct --allow-root

php -d display_errors=on -d date.timezone="Europe/Moscow" -S 0.0.0.0:8000 -t .
