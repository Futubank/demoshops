#!/bin/bash
set -e

rsync -a /opt/drupalcommerce /var/www

exec $@
