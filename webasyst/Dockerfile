FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y mc wget git rsync

#RUN mkdir /opt/webasyst \
#    && cd /opt/webasyst \
#    && wget https://www.webasyst.com/download/framework/shop/ \
#    && mv index.html latest.tar.gz \
#    && tar -xzvf latest.tar.gz

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
