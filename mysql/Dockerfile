#FROM mysql:8
FROM ubuntu:latest

ENV MYSQL_ROOT_PASSWORD=gfgefg297rgfwefr927g3fg23dg413g4d7g348d72384dg29734gd

RUN apt-get update \
    && echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections \
    && echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections \
    && apt-get install -y \
        sudo \
        mysql-server \
    && /etc/init.d/mysql stop

RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf

COPY init/*.sql /init/

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

#CMD ["mysqld", "--default-authentication-plugin=mysql_native_password", "--defaults-extra-file=/my.cnf"]
CMD ["mysqld"]

VOLUME ["/var/lib/mysql", "/var/log/mysql"]
