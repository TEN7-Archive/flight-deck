#!/bin/bash
set -me

SCRIPT_NAME=`basename "$0"`

echo "$SCRIPT_NAME: Starting Varnish in the foreground..."

VARNISH_MEMORY_SIZE=${VARNISH_MEMORY_SIZE:-256m}
VARNISH_STORAGE_SIZE=${VARNISH_STORAGE_SIZE:-1024m}

varnishd -F \
  -a :6081 \
  -T :6082 \
  -f /etc/varnish/default.vcl \
  -S /etc/varnish/secret \
  -s malloc,$VARNISH_MEMORY_SIZE \
  -s secondary=file,/var/lib/varnish/storage.bin,$VARNISH_STORAGE_SIZE
