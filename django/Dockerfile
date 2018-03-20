FROM python:3.5

RUN pip install \
    Django \
    mysqlclient \
    git+https://github.com/Futubank/django-futupayments@a3a40f972b6b56ccedd119ac6de0311d5ead5037

COPY myshop /opt/myshop

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
