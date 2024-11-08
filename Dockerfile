FROM alpine:3.14
ARG VERSION=1.23.1

# alpine 3.15 - В программу установки добавлена поддержка шифрования.
# Inspiration from https://github.com/gmr/alpine-pgbouncer/blob/master/Dockerfile
# hadolint ignore=DL3003,DL3018
RUN \
  # security
  apk add -U --no-cache --upgrade busybox && \
  # Download
  apk add -U --no-cache autoconf autoconf-doc automake udns udns-dev curl gcc libc-dev libevent libevent-dev libtool make openssl-dev pkgconfig postgresql-client && \
  curl -o  /tmp/pgbouncer-$VERSION.tar.gz -L https://pgbouncer.github.io/downloads/files/$VERSION/pgbouncer-$VERSION.tar.gz && \
  cd /tmp && \
  # Unpack, compile
  tar xvfz /tmp/pgbouncer-$VERSION.tar.gz && \
  cd pgbouncer-$VERSION && \
  ./configure --prefix=/usr --with-udns && \
  make && \
  # Manual install
  cp pgbouncer /usr/bin && \
  mkdir -p /etc/pgbouncer /var/log/pgbouncer /var/run/pgbouncer /var/lib/pgbouncer && \
  # entrypoint installs the configuration, allow to write as postgres user
  addgroup -g 46 -S postgres 2>/dev/null && \
  adduser -u 46 -S -D -H -h /var/lib/pgbouncer -g "PostgreSQL Server" -s /sbin/nologin -G postgres postgres 2>/dev/null && \
  chown -R postgres:postgres /var/run/pgbouncer /etc/pgbouncer /var/lib/pgbouncer && \
  chmod 777 /etc/pgbouncer && \
  cp etc/pgbouncer.ini /var/lib/pgbouncer/pgbouncer.ini.example && \
  # Cleanup
  cd /tmp && \
  rm -rf /tmp/pgbouncer*  && \
  apk del --purge autoconf autoconf-doc automake udns-dev curl gcc libc-dev libevent-dev libtool make libressl-dev pkgconfig

COPY ul.sh /var/lib/pgbouncer/
COPY pgbouncer.ini.zabbix /var/lib/pgbouncer/
COPY readme.txt /var/lib/pgbouncer/

RUN \
  chown -R postgres:postgres /var/lib/pgbouncer && \
  echo "source ~/.ashrc" > /etc/profile.d/ashrc.sh

COPY entrypoint.sh /entrypoint.sh

RUN chmod 777 /entrypoint.sh

USER postgres

RUN echo 'alias nocomments="sed -e :a -re '"'"'s/<\!--.*?-->//g;/<\!--/N;//ba'"'"' | sed -e :a -re '"'"'s/\/\*.*?\*\///g;/\/\*/N;//ba'"'"' | grep -v -E '"'"'^\s*(#|;|--|//|$)'"'"'"' >> ~/.ashrc

EXPOSE 5432

ENV ENV="/etc/profile"

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/pgbouncer", "/etc/pgbouncer/pgbouncer.ini"]

WORKDIR /etc/pgbouncer
