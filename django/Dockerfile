FROM python:3.5

RUN mkdir /opt/myshop

COPY requirements.txt /opt/myshop/requirements.txt
RUN pip install -r /opt/myshop/requirements.txt

COPY myshop /opt/myshop

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
