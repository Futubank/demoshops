#!/bin/bash
set -e

set +e; sudo pkill mysqld; set -e
/etc/init.d/mysql start

for f in /init/*; do
    case "$f" in
        *.sql)
            echo "$0: running $f"
            mysql --password=${MYSQL_ROOT_PASSWORD} < $f
            echo
            ;;
        *)
            echo "$0: ignoring $f"
            ;;
    esac
    echo
done

#/etc/init.d/mysql stop
sudo killall mysqld

exec $@
