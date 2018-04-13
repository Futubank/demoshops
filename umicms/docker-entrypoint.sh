#!/bin/bash
set -e

cp -f /dist/* /var/www/umicms/

exec $@
