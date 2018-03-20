#!/usr/bin/env bash

# Wait for database to get available
M_LOOPS="10"
DB_HOST=mysql
DB_PORT=3306

i=0
# http://stackoverflow.com/a/19956266/4848859
while ! curl $DB_HOST:$DB_PORT >/dev/null 2>&1 < /dev/null; do
  i=`expr $i + 1`

  if [ $i -ge $M_LOOPS ]; then
    echo "$(date) - ${DB_HOST}:${DB_PORT} still not reachable, giving up"
    exit 1
  fi

  echo "$(date) - waiting for ${DB_HOST}:${DB_PORT}..."
  sleep 3
done

echo "$(date) - ${DB_HOST}:${DB_PORT} Reachable ! - Starting Daemon"

/opt/myshop/manage.py migrate

exec $@
