#!/bin/bash
set -e

rsync -a /opt/wordpress /var/www

exec $@
