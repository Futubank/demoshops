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
    mysql-server \
    openssh-server \
    rsync \
    unzip \
    wget \
    && useradd www-data \
    && usermod -a -G www-data apache

ADD ./home/ /home/
ADD ./root/ /root/
ADD ./etc/ /etc/

RUN chmod -R 700 /root/.ssh/ /etc/ssh/* /home/www-data/.ssh \
    && chown -R apache:www-data /var/www/html \
    && chown -R www-data:www-data /home/www-data

RUN mkdir -p /opt/netcat \
    && cd /opt/netcat \
    && wget https://netcat.ru/download/distrib/latest/?edition=e-commerce \
    && mv index.html?edition=e-commerce netcat.zip \
    && unzip netcat.zip \
    && rm netcat.zip \
    && ls -lah

VOLUME ["/var/www/html", "/var/log/httpd", "/var/lib/mysql"]
EXPOSE 80 22
CMD ["/root/init.sh"]
