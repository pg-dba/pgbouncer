#!/bin/sh
#Автогенерация userlist.txt

#SELECT usename, passwd FROM pg_shadow WHERE passwd is not null ORDER BY usename;

PGPASSWORD=${DB_PASSWORD} psql -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER} -d postgres -At -c "SELECT '\"' || usename || '\" \"' || passwd || '\"' FROM pg_shadow WHERE passwd is not null ORDER BY usename;" > /tmp/userlist.new.txt

chown postgres:postgres /tmp/userlist.new.txt
mv /tmp/userlist.new.txt /etc/pgbouncer/userlist.new.txt
