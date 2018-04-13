#!/bin/bash
set -e

ls -lah /opt/webasyst
rsync -a /opt/webasyst /var/www

exec $@
