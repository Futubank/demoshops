FROM ubuntu:trusty

RUN apt-get update \
    && apt-get install -y \
        software-properties-common \
        mc \
        wget \
        git \
        rsync \
        apache2 \
        php5 \
        php5-mysql \
        libapache2-mod-php5

RUN apt-get install -y php5-gd php5-curl

# Можно поставить ТОЛЬКО через установщик.
# 1) прописываем cms.my в /etc/hosts
# 2) http://cms.my/install.php
# 3) выбираем «Пакет: cms-7.0.2.0-minimarket.tar.gz»
RUN mkdir /opt/amiro-apache \
    && cd /opt/amiro-apache \
    && wget 'http://amiro.ru/ftpgetfile.php?id=199&module=files' \
    && mv 'ftpgetfile.php?id=199&module=files' install.php

COPY cms.my.conf /etc/apache2/sites-enabled/cms.my.conf
#COPY modulbank-amiro/modulbank _local/eshop/pay_drivers/modulbank

# XXX: apache2 просто так не стартует
# XXX: service apache2 start тоже не алё
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf \
    && a2enconf fqdn \
    && sed -i.bak 's/short_open_tag = .*/short_open_tag = On/' /etc/php5/apache2/php.ini \
    && /etc/init.d/apache2 stop \
    && rm /etc/apache2/sites-enabled/000-default.conf

CMD ["sleep", "infinity"]

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
