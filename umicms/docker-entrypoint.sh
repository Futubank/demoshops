#!/bin/bash
set -e

cp -f /tmp/install.php /var/www/umicms/install.php

exec $@
