# pgbouncer

https://github.com/edoburu/docker-pgbouncer<BR>
https://github.com/edoburu/docker-pgbouncer/blob/master/Dockerfile<BR>
https://github.com/edoburu/docker-pgbouncer/blob/master/entrypoint.sh<BR>

 LISTEN_PORT    6432<BR>
 DB_HOST<BR>
 DB_PORT<BR>
 DB_USER<BR>
 DB_PASSWORD<BR>
 /data/zabbix-pgbouncer:/etc/pgbouncer<BR>

# Автогенерация userlist.txt<BR>

cat <<EOF | psql -U postgres -d postgres<BR>
COPY (SELECT usename, passwd FROM pg_shadow WHERE passwd is not null ORDER BY usename) TO '/var/lib/postgresql/data/userlist.txt' WITH DELIMITER ' ' CSV FORCE QUOTE usename, passwd;<BR>
EOF<BR>

# переместить в нужную папку и выставить права доступа
mv /data/postgres/userlist.txt /data/pgbouncer/<BR>
chmod -R 777 /data/pgbouncer
