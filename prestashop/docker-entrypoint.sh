#/bin/bash
set -e

mkdir -p /opt/opencart
cd /opt/opencart

if [ ! -f "config.php" ]; then
    mkdir tmp
    #wget -O tmp/opencart.zip https://github.com/opencart/opencart/releases/download/2.3.0.2/2.3.0.2-compiled.zip
    wget -O tmp/opencart.zip 'http://opencart-russia.ru/down.php?opencart2.3.0.2'
    ( cd tmp && unzip opencart.zip)
    mv tmp/upload*/* .
    rm -rf tmp
    mv config-dist.php config.php
    mv admin/config-dist.php admin/config.php
    chown -R www-data .
fi

#cp -rfs /opt/modulbank-opencart/upload/* /opt/opencart/  # create symlinks for module files

echo "Starting server. Address is http://$(hostname -I | tr -d ' '):8000"

sudo -u www-data php -d extension=mcrypt.so -S 0.0.0.0:8000 -t .
