#!/bin/bash
set -me

SCRIPT_NAME=`basename "$0"`

echo "$SCRIPT_NAME: Starting Varnish in the foreground..."

SECRETS_DIR=${SECRETS_DIR:-/secrets}
CONFIG_DIR=${CONFIG_DIR:-/config}

if [ -s "$CONFIG_DIR/VARNISH_HTTP_PORT" ]; then
  echo "$SCRIPT_NAME: Loading VARNISH_HTTP_PORT from ConfigMap"
  VARNISH_HTTP_PORT="$(<$CONFIG_DIR/VARNISH_HTTP_PORT)"
else
  echo "$SCRIPT_NAME: Loading VARNISH_HTTP_PORT from env"
  VARNISH_HTTP_PORT=${VARNISH_HTTP_PORT:-6081}
fi

if [ -s "$CONFIG_DIR/VARNISH_CONTROL_PORT" ]; then
  echo "$SCRIPT_NAME: Loading VARNISH_CONTROL_PORT from ConfigMap"
  VARNISH_CONTROL_PORT="$(<$CONFIG_DIR/VARNISH_CONTROL_PORT)"
else
  echo "$SCRIPT_NAME: Loading VARNISH_HTTP_PORT from env"
  VARNISH_CONTROL_PORT=${VARNISH_CONTROL_PORT:-6082}
fi

if [ -s "$CONFIG_DIR/VARNISH_MEMORY_SIZE" ]; then
  echo "$SCRIPT_NAME: Loading VARNISH_MEMORY_SIZE from ConfigMap"
  VARNISH_MEMORY_SIZE="$(<$CONFIG_DIR/VARNISH_MEMORY_SIZE)"
else
  echo "$SCRIPT_NAME: Loading VARNISH_HTTP_PORT from env"
  VARNISH_MEMORY_SIZE=${VARNISH_MEMORY_SIZE:-256m}
fi

if [ -s "$CONFIG_DIR/VARNISH_STORAGE_SIZE" ]; then
  echo "$SCRIPT_NAME: Loading VARNISH_STORAGE_SIZE from ConfigMap"
  VARNISH_STORAGE_SIZE="$(<$CONFIG_DIR/VARNISH_STORAGE_SIZE)"
else
  echo "$SCRIPT_NAME: Loading VARNISH_HTTP_PORT from env"
  VARNISH_STORAGE_SIZE=${VARNISH_STORAGE_SIZE:-1024m}
fi

varnishd -F \
  -a :$VARNISH_HTTP_PORT \
  -T :$VARNISH_CONTROL_PORT \
  -f /etc/varnish/default.vcl \
  -S /etc/varnish/secret \
  -s malloc,$VARNISH_MEMORY_SIZE \
  -s secondary=file,/var/lib/varnish/storage.bin,$VARNISH_STORAGE_SIZE
