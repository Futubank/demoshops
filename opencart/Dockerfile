FROM ubuntu:18.04

EXPOSE 8000

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y \
        wget unzip sudo \
        php-cli php-gd php-curl php-zip \
        libmcrypt-dev php-dev \
        php-pear php-mysql \
    && mkdir /tmp/build \
    && yes | pecl install channel://pecl.php.net/mcrypt-1.0.1 \
    && apt-get autoremove -y \
    && apt-get clean

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y \
    rsync php-mbstring

ADD docker-entrypoint.sh /

WORKDIR /opt/opencart

CMD /docker-entrypoint.sh
