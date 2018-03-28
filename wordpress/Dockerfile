FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y mc wget git rsync

RUN cd /tmp \
    && mkdir /opt/wordpress \
    && wget https://wordpress.org/latest.tar.gz \
    && tar -xzvf latest.tar.gz \
    && mv wordpress /opt/

COPY modulbank-wordpress-shortcode/modulbank-shortcode /opt/wordpress/wp-content/plugins/modulbank-shortcode
COPY wp-config.php /opt/wordpress/wp-config.php

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
