# вот так не работает (ошибка apt-get install)
#FROM ubuntu:16.04
# а так работает, хотя это одно и то же
FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y \
        php-mysql \
        php-mbstring \
        php-xml \
        php-curl \
        php-simplexml \
        php-gd \
        php-gmp \
        php-fpm \
    && /etc/init.d/php7.0-fpm stop

RUN sed -i.bak 's/listen = .*/listen = 9000/' /etc/php/7.0/fpm/pool.d/www.conf
RUN sed -i.bak 's/pid = .*/pid = \/tmp\/php-fpm.pid/' /etc/php/7.0/fpm/php-fpm.conf
RUN sed -i.bak 's/;error_log = syslog/error_log = \/var\/log\/php_error.log/' /etc/php/7.0/fpm/php.ini

RUN sed -i.bak 's/short_open_tag = .*/short_open_tag = On/' /etc/php/7.0/fpm/php.ini

CMD ["php-fpm7.0", "--nodaemonize", "--force-stderr", "--pid", "/tmp/php-fpm.pid", "--fpm-config", "/etc/php/7.0/fpm/php-fpm.conf", "-c", "/etc/php/7.0/fpm/php.ini"]
