FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y \
        software-properties-common \
    && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y \
        php5.6-fpm

RUN apt-get install -y \
        php5.6-mysql \
        php5.6-mbstring \
        php5.6-xml \
        php5.6-curl \
        php5.6-simplexml \
        php5.6-gd \
    && /etc/init.d/php5.6-fpm stop

RUN sed -i.bak 's/listen = .*/listen = 9000/' /etc/php/5.6/fpm/pool.d/www.conf
RUN sed -i.bak 's/pid = .*/pid = \/tmp\/php-fpm.pid/' /etc/php/5.6/fpm/php-fpm.conf
RUN sed -i.bak 's/;error_log = syslog/error_log = \/var\/log\/php_error.log/' /etc/php/5.6/fpm/php.ini
RUN sed -i.bak 's/;memory_limit = .*/memory_limit = 1024M/' /etc/php/5.6/fpm/php.ini

# amocrm
RUN sed -i.bak 's/short_open_tag = .*/short_open_tag = On/' /etc/php/5.6/fpm/php.ini

#RUN sed -i.bak 's/;access.log = .*/access.log = \/var\/log\/php-fpm-access.log/' /etc/php/5.6/fpm/pool.d/www.conf

CMD ["php-fpm5.6", "--nodaemonize", "--force-stderr", "--pid", "/tmp/php-fpm.pid", "--fpm-config", "/etc/php/5.6/fpm/php-fpm.conf", "-c", "/etc/php/5.6/fpm/php.ini"]
