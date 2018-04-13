FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y mc wget git rsync

RUN mkdir dist \
    && cd /dist \
    && wget 'http://amiro.ru/ftpgetfile.php?id=199&module=files' \
    && mv 'ftpgetfile.php?id=199&module=files' install.php

# COPY modulbank-amiro/modulbank /opt/amiro/_local/eshop/pay_drivers/modulbank

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
