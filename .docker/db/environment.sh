#!/usr/bin/env bash

if [ -n "$MYSQL_MAX_ALLOWED_PACKET" ]; then
    sed -i 's/^max_allowed_packet.*/'"max_allowed_packet = ${MYSQL_MAX_ALLOWED_PACKET}"'/' /etc/mysql/my.cnf
fi
