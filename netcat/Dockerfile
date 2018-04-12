FROM centos:6.6
# MAINTAINER "Egor Zyuskin" <ezyuskin@amaxlab.ru>

RUN yum -y install \
    curl \
    httpd \
    php \
    php-gd \
    php-xml \
    php-mysql \
    php-mbstring \
    openssh-server \
    rsync \
    unzip \
    wget \
    && useradd www-data \
    && usermod -a -G www-data apache

ADD ./home/ /home/
ADD ./root/ /root/
ADD ./etc/ /etc/

RUN mkdir -p /opt/netcat \
    && cd /opt/netcat \
    && wget https://netcat.ru/download/distrib/latest/?edition=e-commerce \
    && mv index.html?edition=e-commerce netcat.zip \
    && unzip netcat.zip \
    && rm netcat.zip \
    && ls -lah

COPY modulbank-netcat /opt/modulbank-netcat

VOLUME ["/var/www/html", "/var/log/httpd"]
EXPOSE 80 22
CMD ["/root/init.sh"]
