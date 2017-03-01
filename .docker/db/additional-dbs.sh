#!/usr/bin/env bash

if [ -n "$ADDITIONAL_DATABASES" ]; then
    for ADD_DB_NAME in $ADDITIONAL_DATABASES; do
      echo "CREATE DATABASE IF NOT EXISTS $ADD_DB_NAME" | mysql --user=root --password=$MYSQL_ROOT_PASSWORD
      echo "GRANT ALL ON \`$ADD_DB_NAME\`.* TO '$MYSQL_USER'@'%' ;" | mysql --user=root --password=$MYSQL_ROOT_PASSWORD
    done;

    mysqladmin --user=root --password=$MYSQL_ROOT_PASSWORD flush-privileges
fi
