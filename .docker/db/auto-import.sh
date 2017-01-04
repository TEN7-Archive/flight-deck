#! /bin/bash

CWD=$( pwd )

cd /tmp/db-backups
LATEST_DUMP=`ls -td *sql | head -1`
echo $LATEST_DUMP

mysql --user=root --password=$MYSQL_ROOT_PASSWORD -C $MYSQL_DATABASE < $LATEST_DUMP;

cd $CWD
