FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y \
        php7.0-fpm \
        php-mysql \
    && /etc/init.d/php7.0-fpm stop

RUN sed -i.bak 's/listen = .*/listen = 9000/' /etc/php/7.0/fpm/pool.d/www.conf
RUN sed -i.bak 's/pid = .*/pid = \/tmp\/php-fpm.pid/' /etc/php/7.0/fpm/php-fpm.conf
RUN sed -i.bak 's/;error_log = syslog/error_log = \/var\/log\/php_error.log/' /etc/php/7.0/fpm/php.ini
RUN sed -i.bak 's/;memory_limit = .*/memory_limit = 1024M/' /etc/php/7.0/fpm/php.ini
#RUN sed -i.bak 's/;access.log = .*/access.log = \/var\/log\/php-fpm-access.log/' /etc/php/7.0/fpm/pool.d/www.conf

CMD ["php-fpm7.0", "--nodaemonize", "--force-stderr", "--pid", "/tmp/php-fpm.pid", "--fpm-config", "/etc/php/7.0/fpm/php-fpm.conf", "-c", "/etc/php/7.0/fpm/php.ini"]
