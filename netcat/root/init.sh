#!/bin/bash
set -e

#rsync -a /opt/netcat/* /var/www/html

ls -lah /opt/

cp /opt/modulbank-netcat/netcat/modules/payment/classes/system/* \
    /var/www/html/netcat/modules/payment/classes/system/

rm -f /var/run/httpd/httpd.pid

exec httpd -DFOREGROUND
