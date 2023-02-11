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

<pre><code>cat \<\<EOF | psql -U postgres -d postgres
COPY (SELECT usename, passwd FROM pg_shadow WHERE passwd is not null AND usename not in ('postgres') ORDER BY usename) 
TO '/var/lib/postgresql/data/userlist.txt' WITH DELIMITER ' ' CSV FORCE QUOTE usename, passwd;
EOF
</code></pre>

# переместить в нужную папку и выставить права доступа
<pre><code>mv /data/postgres/userlist.txt /data/pgbouncer/
chmod -R 777 /data/pgbouncer
</code></pre>
