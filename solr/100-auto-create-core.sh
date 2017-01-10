#! /bin/sh

DRUPAL_VERSION=${DRUPAL_VERSION:-7}

if [ -n "$SOLR_CORE_NAME" ]; then
  if [ -d "/opt/solr/server/solr/$SOLR_CORE_NAME" ]; then
    echo Reloading core $SOLR_CORE_NAME
    solr-reload-core $SOLR_CORE_NAME
  else
    echo Creating core $SOLR_CORE_NAME...
    solr-create-core $SOLR_CORE_NAME drupal$DRUPAL_VERSION
  fi
fi
