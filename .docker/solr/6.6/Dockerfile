FROM solr:6.6-alpine
MAINTAINER tess@ten7.com

USER root

RUN apk add --update --no-cache \
      ansible \
      bash \
      rsync \
      curl

ADD http://ftp.drupal.org/files/projects/search_api_solr-8.x-2.x-dev.tar.gz /opt/search_api_solr.tar.gz
RUN tar -xzf /opt/search_api_solr.tar.gz -C /opt/

# Copy various key scripts to a directory in $PATH.
COPY docker-entrypoint.sh /usr/local/bin/

# Make them all executable.
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

# Copy the entire contents of the init.d directory.
COPY docker-entrypoint-init.d /docker-entrypoint-init.d
RUN chmod a+x -R /docker-entrypoint-init.d

# Copy the root bashrc file.
COPY bashrc-root /root/.bashrc

# Copy the Ansible configuration files
COPY ansible-hosts /etc/ansible/hosts
COPY ansible.cfg /etc/ansible/ansible.cfg

USER $SOLR_USER

# Copy the user bashrc file.
COPY bashrc-user /home/solr/.bashrc

EXPOSE 8983

# Set the entrypoint and default command.
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["solr-foreground"]
