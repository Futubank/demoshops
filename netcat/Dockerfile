FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y \
        mc \
        rsync \
        curl \
        php-cli \
        php-curl \
        php-dom \
        php-gd \
        php-mbstring \
        php-bcmath \
        git \
        wget \
    && curl -sS https://getcomposer.org/installer -o composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN mkdir -p /opt/netcat \
    && cd /opt/netcat \
    && wget https://netcat.ru/download/distrib/latest/?edition=e-commerce \
    && mv index.html?edition=e-commerce netcat.zip \
    && unzip netcat.zip \
    && rm netcat.zip \
    && ls -lah

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
