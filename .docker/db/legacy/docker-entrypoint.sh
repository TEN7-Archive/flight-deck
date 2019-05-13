#!/bin/bash
set -me

SCRIPT_NAME=`basename "$0"`

echo "$SCRIPT_NAME: Beginning initialization..."

run-parts /docker-entrypoint-init.d

# Stop the background MySQL if any.
mysql-background-stop.sh || true

echo "$SCRIPT_NAME: Initialization complete. Starting container..."

exec "$@"
