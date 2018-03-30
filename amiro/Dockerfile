FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y mc wget git rsync

# здесь строго установка!!!
#
# https://www.amiro.ru/how-to/demo/download
# пароли: amiro / amiro / amiro amiro
RUN mkdir /opt/amiro \
    && cd /opt/amiro \
    && wget 'http://amiro.ru/ftpgetfile.php?id=199&module=files' \
    && mv 'ftpgetfile.php?id=199&module=files' install.php

COPY modulbank-amiro/modulbank _local/eshop/pay_drivers/modulbank

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
