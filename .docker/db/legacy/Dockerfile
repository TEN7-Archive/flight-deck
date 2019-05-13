FROM alpine:3.9
MAINTAINER tess@ten7.com

# Update all the Alpine packages.
RUN apk -U upgrade && \
    apk add --update --no-cache \
      ansible \
      bash \
      pwgen \
      mariadb \
      mariadb-client && \
    rm -rf /tmp/* /var/cache/apk/* && \
    mkdir -p -m 774 \
      /var/run/mysqld/ && \
    chown -R mysql:mysql \
      /var/run/mysqld/ \
      /etc/mysql \
      /etc/my.cnf \
      /etc/my.cnf.d

# Copy the MySQL configuration file.
COPY my.cnf.d /etc/my.cnf.d

# Copy various key scripts to a directory in $PATH.
COPY docker-entrypoint.sh /usr/local/bin/
COPY mysql-background-start.sh /usr/local/bin/
COPY mysql-background-stop.sh /usr/local/bin/

# Copy the entire contents of the init.d directory.
COPY docker-entrypoint-init.d /docker-entrypoint-init.d

# Make them all executable.
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh && \
    chmod a+x /usr/local/bin/mysql-background-start.sh && \
    chmod a+x /usr/local/bin/mysql-background-stop.sh && \
    chmod a+x -R /docker-entrypoint-init.d

# Configure the runtime environment of the container.
VOLUME /var/lib/mysql
WORKDIR /var/lib/mysql
EXPOSE 3306

# Copy the root bashrc file.
COPY bashrc-root /root/.bashrc

# Copy the Ansible configuration files
COPY ansible-hosts /etc/ansible/hosts
COPY ansible.cfg /etc/ansible/ansible.cfg

# Switch to the mysql user.
USER mysql

# Copy the user bashrc file.
COPY bashrc-user /var/lib/mysql/.bashrc

# Set the entrypoint and default command.
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld_safe", "--user=mysql", "--console"]
