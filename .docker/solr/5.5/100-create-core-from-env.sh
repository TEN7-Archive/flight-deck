#!/bin/bash

function create_solr_core {
    rm -rf /tmp/schema
    mkdir -p /tmp/schema
    cd /tmp/schema

    if [[ "$DRUPAL_VERSION" = '8' ]]; then
        wget -nv https://ftp.drupal.org/files/projects/search_api_solr-8.x-1.0-beta1.tar.gz
        tar xzf search_api_solr*
        /opt/solr/bin/solr create_core -c "$SOLR_CORE_NAME" -p 8983 -d ./search_api_solr/solr-conf/5.x/
    elif [[ "$DRUPAL_VERSION" = '7' ]]; then
        wget -nv https://ftp.drupal.org/files/projects/search_api_solr-7.x-1.11.tar.gz
        tar xzf search_api_solr*
        /opt/solr/bin/solr create_core -c "$SOLR_CORE_NAME" -p 8983 -d ./search_api_solr/solr-conf/5.x/
    else
        echo "Creating core with a default configuration:"
        solr create_core -c "$SOLR_CORE_NAME"
    fi

    rm -rf /tmp/schema
    echo 'Done!'
}

if [ -n "$SOLR_CORE_NAME" ]; then
  if [ -d "/opt/solr/server/solr/$SOLR_CORE_NAME" ]; then
    echo Core $SOLR_CORE_NAME already created.
  else
    echo Creating new core $SOLR_CORE_NAME...
    create_solr_core
  fi
fi
