#!/bin/bash
set -e

cp /dist/* /var/www/amirocms/

exec $@
