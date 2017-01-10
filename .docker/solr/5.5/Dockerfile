FROM wodby/solr:5.5-1.0.0
MAINTAINER tess@ten7.com

USER root
RUN mkdir /docker-entrypoint-start.d

COPY 100-create-core-from-env.sh /docker-entrypoint-start.d
RUN chown -R $SOLR_USER:$SOLR_USER /docker-entrypoint-start.d
RUN chmod -R 755 /docker-entrypoint-start.d

# Replace the original entrypoint with our custom one.
COPY run.sh /opt/docker-solr/scripts/
RUN chown $SOLR_USER:$SOLR_USER /opt/docker-solr/scripts/run.sh
RUN chmod +x /opt/docker-solr/scripts/run.sh

ENV PATH /opt/solr/bin:/opt/docker-solr/scripts:$PATH

USER $SOLR_USER

ENTRYPOINT ["run.sh"]
CMD ["solr-foreground"]
