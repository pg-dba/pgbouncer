# https://www.pgbouncer.org/usage.html

### connect to pgbouncer ###

PGPASSWORD=${DB_PASSWORD} psql -h 127.0.0.1 -p 6432 -U ${DB_USER} -d pgbouncer

PGPASSWORD=${DB_PASSWORD} psql -h 127.0.0.1 -p 6432 -U ${DB_USER} -d pgbouncer -c 'SHOW FDS;'

PGPASSWORD=${DB_PASSWORD} psql -h 127.0.0.1 -p 6432 -U ${DB_USER} -d pgbouncer -c 'SHOW HELP;'
#NOTICE:  Console usage
#DETAIL:  
#        SHOW HELP|CONFIG|DATABASES|POOLS|CLIENTS|SERVERS|USERS|VERSION
#        SHOW FDS|SOCKETS|ACTIVE_SOCKETS|LISTS|MEM
#        SHOW DNS_HOSTS|DNS_ZONES
#        SHOW STATS|STATS_TOTALS|STATS_AVERAGES|TOTALS
#        SET key = arg
#        RELOAD
#        PAUSE [<db>]
#        RESUME [<db>]
#        DISABLE <db>
#        ENABLE <db>
#        RECONNECT [<db>]
#        KILL <db>
#        SUSPEND
#        SHUTDOWN
#        WAIT_CLOSE [<db>]

