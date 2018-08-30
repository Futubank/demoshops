FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y \
        mc \
        wget \
        git \
        rsync \
        php-cli \
        php-mysql \
        php-mbstring \
        curl

RUN cd /tmp \
    && mkdir -p /opt/woocommerce \
    && wget https://wordpress.org/latest.tar.gz \
    && tar -xzvf latest.tar.gz \
    && mv wordpress/* /opt/woocommerce/

RUN cd /tmp \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && php wp-cli.phar --info \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp cli update

RUN cd /tmp \
    && wget https://github.com/woocommerce/woocommerce/archive/3.4.5.tar.gz \
    && tar -xzvf 3.4.5.tar.gz \
    && mv woocommerce-3.4.5 /opt/woocommerce/wp-content/plugins/woocommerce

#COPY modulbank-woocommerce/modulbank/ /opt/woocommerce/wp-content/plugins/modulbank/
COPY wp-config.php /opt/woocommerce/wp-config.php

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
