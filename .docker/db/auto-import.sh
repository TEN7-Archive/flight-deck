#! /bin/bash

CWD=$( pwd )

if [ "$MYSQL_AUTO_IMPORT" -ne "1" ]; then
  exit 0
fi

cd /tmp/db-backups
LATEST_DUMP=`ls -td *sql* | head -1`
echo $LATEST_DUMP

case "$LATEST_DUMP" in
    *.gz)
          echo Importing gzip compressed file $LATEST_DUMP
          zcat $LATEST_DUMP | mysql --user=root --password=$MYSQL_ROOT_PASSWORD -C $MYSQL_DATABASE
          ;;
    *.xz)
          echo Importing xz compressed file $LATEST_DUMP
          xzcat $LATEST_DUMP | mysql --user=root --password=$MYSQL_ROOT_PASSWORD -C $MYSQL_DATABASE
          ;;
    *.lzo)
          echo Importing lzo compressed file $LATEST_DUMP
          lzopcat $LATEST_DUMP | mysql --user=root --password=$MYSQL_ROOT_PASSWORD -C $MYSQL_DATABASE
          ;;
    *.sql)
          echo Importing uncomressed sql file $LATEST_DUMP
          mysql --user=root --password=$MYSQL_ROOT_PASSWORD -C $MYSQL_DATABASE < $LATEST_DUMP;
          ;;
    *.mysql)
          echo Importing uncomressed mysql file $LATEST_DUMP
          mysql --user=root --password=$MYSQL_ROOT_PASSWORD -C $MYSQL_DATABASE < $LATEST_DUMP;
          ;;
esac

cd $CWD
