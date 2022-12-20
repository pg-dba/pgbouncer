#!/bin/sh
#Автогенерация userlist.txt

cat <<EOF | PGPASSWORD=${DB_PASSWORD} psql -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER} -d postgres
COPY (SELECT usename, passwd FROM pg_shadow WHERE passwd is not null ORDER BY usename) TO '/tmp/userlist.new.txt' WITH DELIMITER ' ' CSV FORCE QUOTE usename, passwd;
EOF

chown postgres:postgres /tmp/userlist.new.txt
mv /tmp/userlist.new.txt /etc/pgbouncer/userlist.new.txt
