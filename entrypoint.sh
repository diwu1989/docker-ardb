#!/bin/bash
GEN_RANDOM=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
PASSWORD=${PASSWORD:=$GEN_RANDOM}
echo "requirepass $PASSWORD"
echo "requirepass $PASSWORD" >> /etc/ardb.conf
exec /usr/bin/ardb-server /etc/ardb.conf
