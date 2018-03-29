FROM python:3.5

RUN mkdir /opt/myshop

COPY requirements.txt /opt/myshop/requirements.txt
RUN pip install --upgrade pip \
    && pip install -r /opt/myshop/requirements.txt

COPY modulbank-django /tmp/modulbank-django
RUN cd /tmp/modulbank-django \
    && python3 setup.py install

COPY myshop /opt/myshop

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
