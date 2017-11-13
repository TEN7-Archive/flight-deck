FROM solr:6.6.0-alpine
MAINTAINER tess@ten7.com

USER root

RUN apk add --update --no-cache \
      rsync

ADD http://ftp.drupal.org/files/projects/search_api_solr-8.x-1.x-dev.tar.gz /opt/search_api_solr.tar.gz
RUN tar -xzf /opt/search_api_solr.tar.gz -C /opt/

# Replace the original entrypoint with our custom one.
COPY create-from-envars /opt/docker-solr/scripts/
RUN chown $SOLR_USER:$SOLR_USER /opt/docker-solr/scripts/create-from-envars
RUN chmod +x /opt/docker-solr/scripts/create-from-envars

USER $SOLR_USER

EXPOSE 8983

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["create-from-envars"]
