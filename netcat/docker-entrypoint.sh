#!/bin/bash
set -e

rsync -a /opt/netcat /var/www

exec $@
