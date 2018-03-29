FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y mc wget git rsync

#RUN mkdir /opt/amiro \
#    && cd /opt/amiro \
#    && wget 'http://amiro.ru/ftpgetfile.php?id=128&module=files' \
#    && mv 'ftpgetfile.php?id=128&module=files' amiro.tar.gz \
#    && tar -xzvf amiro.tar.gz \
#    && rm amiro.tar.gz

## https://www.amiro.ru/how-to/demo/download
#RUN mkdir /opt/amiro \
#    && cd /opt/amiro \
#    && wget 'http://amiro.ru/ftpgetfile.php?id=199&module=files' \
#    && mv 'ftpgetfile.php?id=199&module=files' install.php

RUN mkdir /opt/amiro
COPY dist /opt/amiro

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
