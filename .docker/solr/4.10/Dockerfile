FROM openjdk:8-jre-alpine
MAINTAINER tess@ten7.com

# Override the solr download location with e.g.:
#   docker build -t mine --build-arg SOLR_DOWNLOAD_SERVER=http://www-eu.apache.org/dist/lucene/solr .
ARG SOLR_DOWNLOAD_SERVER

RUN apk add --no-cache \
        lsof \
        gnupg \
        procps \
        tar \
        ansible \
        bash \
        curl \
        rsync

RUN apk add --no-cache ca-certificates wget && \
        update-ca-certificates

ENV SOLR_USER="solr" \
    SOLR_UID="8983" \
    SOLR_GROUP="solr" \
    SOLR_GID="8983" \
    SOLR_VERSION="4.10.4" \
    SOLR_URL="${SOLR_DOWNLOAD_SERVER:-https://archive.apache.org/dist/lucene/solr}/4.10.4/solr-4.10.4.tgz" \
    SOLR_KEYS="5F55943E13D49059D3F342777186B06E1ED139E7" \
    PATH="/opt/solr/bin:/opt/docker-solr/scripts:$PATH"

ENV GOSU_VERSION 1.10
ENV GOSU_KEY B42F6819007F00F88E364FD4036A9C25BF357DD4

RUN addgroup -S -g $SOLR_GID $SOLR_GROUP && \
    adduser -S -u $SOLR_UID -G $SOLR_GROUP $SOLR_USER

RUN set -e; \
  export GNUPGHOME="/tmp/gnupg_home" && \
  mkdir -p "$GNUPGHOME" && \
  chmod 700 "$GNUPGHOME" && \
  for key in $SOLR_KEYS $GOSU_KEY; do \
    found=''; \
    for server in \
      ha.pool.sks-keyservers.net \
      hkp://keyserver.ubuntu.com:80 \
      hkp://p80.pool.sks-keyservers.net:80 \
      pgp.mit.edu \
    ; do \
      echo "  trying $server for $key"; \
      gpg --keyserver "$server" --keyserver-options timeout=10 --recv-keys "$key" && found=yes && break; \
    done; \
    test -z "$found" && echo >&2 "error: failed to fetch $key from several disparate servers -- network issues?" && exit 1; \
  done; \
  exit 0

RUN set -e; \
  export GNUPGHOME="/tmp/gnupg_home" && \
  apkArch="$(apk --print-arch | sed 's/x86_64/amd64/')"; \
  wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$apkArch"; \
  chmod +x /usr/local/bin/gosu && \
  gosu nobody true

RUN set -e; \
  mkdir -p /opt/solr && \
  echo "downloading $SOLR_URL" && \
  wget -q $SOLR_URL -O /opt/solr.tgz && \
  tar -C /opt/solr --extract --file /opt/solr.tgz --strip-components=1 && \
  rm /opt/solr.tgz* && \
  rm -Rf /opt/solr/docs/ && \
  mkdir -p /opt/solr/server/solr/lib /opt/solr/server/solr/mycores /opt/solr/server/logs /docker-entrypoint-initdb.d /opt/docker-solr /opt/mysolrhome && \
  sed -i -e 's/"\$(whoami)" == "root"/$(id -u) == 0/' /opt/solr/bin/solr && \
  sed -i -e 's/lsof -PniTCP:/lsof -t -PniTCP:/' /opt/solr/bin/solr && \
  sed -i -e '/-Dsolr.clustering.enabled=true/ a SOLR_OPTS="$SOLR_OPTS -Dsun.net.inetaddr.ttl=60 -Dsun.net.inetaddr.negative.ttl=60"' /opt/solr/bin/solr.in.sh && \
  chown -R $SOLR_USER:$SOLR_GROUP /opt/solr

# Get the Search API module so we can use provided conf.
ADD http://ftp.drupal.org/files/projects/search_api_solr-8.x-1.x-dev.tar.gz /opt/search_api_solr.tar.gz
RUN tar -xzf /opt/search_api_solr.tar.gz -C /opt/

# Get the ApacheSolr module so we can use provided conf.
ADD https://ftp.drupal.org/files/projects/apachesolr-7.x-1.x-dev.tar.gz /opt/apachesolr.tar.gz
RUN tar -xzf /opt/apachesolr.tar.gz -C /opt/

# Copy various key scripts to a directory in $PATH.
COPY docker-entrypoint.sh /usr/local/bin/
COPY scripts /opt/docker-solr/scripts

# Make them all executable.
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh
RUN chown -R $SOLR_USER:$SOLR_GROUP /opt/docker-solr /opt/mysolrhome

# Copy the entire contents of the init.d directory.
COPY docker-entrypoint-init.d /docker-entrypoint-init.d
RUN chmod a+x -R /docker-entrypoint-init.d

# Change the default ownership of the example Solr directory.
RUN chown -R solr:solr /opt/solr/example/solr

# Copy the Ansible configuration files
COPY ansible-hosts /etc/ansible/hosts
COPY ansible.cfg /etc/ansible/ansible.cfg

EXPOSE 8983
WORKDIR /opt/solr
USER $SOLR_USER

# Set the entrypoint and default command.
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["solr-foreground"]
