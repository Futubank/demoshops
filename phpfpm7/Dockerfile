FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y \
        php7.2-mysql \
        php7.2-mbstring \
        php7.2-xml \
        php7.2-curl \
        php7.2-simplexml \
        php7.2-gd \
    && /etc/init.d/php7.2-fpm stop

RUN sed -i.bak 's/listen = .*/listen = 9000/' /etc/php/7.2/fpm/pool.d/www.conf
RUN sed -i.bak 's/pid = .*/pid = \/tmp\/php-fpm.pid/' /etc/php/7.2/fpm/php-fpm.conf
RUN sed -i.bak 's/;error_log = syslog/error_log = \/var\/log\/php_error.log/' /etc/php/7.2/fpm/php.ini

CMD ["php-fpm7.2", "--nodaemonize", "--force-stderr", "--pid", "/tmp/php-fpm.pid", "--fpm-config", "/etc/php/7.2/fpm/php-fpm.conf", "-c", "/etc/php/7.2/fpm/php.ini"]
