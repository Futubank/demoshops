FROM ubuntu:18.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        mc \
        rsync \
        curl \
        git \
        software-properties-common \
        php-cli \
        php-curl \
        php-dom \
        php-gd \
        php-mbstring \
        php-bcmath \
    && curl -sS https://getcomposer.org/installer -o composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN cd /opt/ \
    && git clone https://github.com/AcroMedia/commerce-demo.git \
    && cd commerce-demo \
    && composer install

#RUN cd /opt/ \
#    && composer create-project drupalcommerce/project-base drupalcommerce --stability dev --no-interaction

#RUN cat /dev/zero | ssh-keygen -q -N "" \
#    && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts \
#    && cd /tmp \
#    && git clone --mirror 'git@github.com:drupalcommerce/commerce_base.git'
#
#RUN cd /opt/drupalcommerce \
#    && composer config repositories.mglaman vcs https://github.com/mglaman/commerce_examples \
#    && composer require drupal/commerce_examples:dev-master

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
