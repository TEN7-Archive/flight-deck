#!/bin/bash

# We can't use set -me here as stop-local-solr returns non-zero if no instance is started.

SCRIPT_NAME=`basename "$0"`

echo "$SCRIPT_NAME: Beginning initialization..."

run-parts /docker-entrypoint-init.d

# Stop the background Solr if any.
stop-local-solr

echo "$SCRIPT_NAME: Initialization complete. Starting container..."

exec "$@"
