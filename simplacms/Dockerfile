FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y mc wget git rsync

COPY dist /dist

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
