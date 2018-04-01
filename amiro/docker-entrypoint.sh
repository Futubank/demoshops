#!/bin/bash
set -e

rsync -a /opt/amiro /var/www

exec $@
