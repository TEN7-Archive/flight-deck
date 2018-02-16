#!/bin/bash

# We *don't* start with set -me, because mysqladmin may fail, and we want that.

SCRIPT_NAME=`basename "$0"`

# Check if MySQL is running, squelching the terminal output.
mysqladmin ping 2>/dev/null 1>/dev/null

# Capture the output of mysqladmin ping
MYSQL_STATUS="${?}"

if [ "$MYSQL_STATUS" -eq 1 ]; then
  echo "$SCRIPT_NAME: Starting MySQL in the background."
  mysqld_safe --user=mysql --console &

  while [[ "$MYSQL_STATUS" -eq 1 ]]
  do
    echo "$SCRIPT_NAME: Waiting for startup to complete..."
    sleep 1

    # Ping again, capturing the return code.
    mysqladmin ping 2>/dev/null 1>/dev/null
    MYSQL_STATUS=${?}
  done
fi
