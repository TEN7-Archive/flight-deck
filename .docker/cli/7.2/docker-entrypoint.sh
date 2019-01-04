#!/bin/bash
set -me

SCRIPT_NAME=`basename "$0"`

echo "$SCRIPT_NAME: Beginning initialization..."

run-parts /docker-entrypoint-init.d

echo "$SCRIPT_NAME: Initialization complete. Starting container..."

exec "$@"
