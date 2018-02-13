FROM alpine:3.6
MAINTAINER tess@ten7.com

# Update all the Alpine packages.
RUN apk -U upgrade

# Install Apache and PHP.
RUN apk add --update --no-cache \
            ansible \
            bash \
            pwgen \
            mariadb \
            mariadb-client \
            && rm -rf /tmp/* \
            && rm -rf /var/cache/apk/*

# Copy various key scripts to a directory in $PATH.
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

COPY mysql-background-start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mysql-background-start.sh

COPY mysql-background-stop.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mysql-background-stop.sh

# Copy the entire contents of the init.d directory.
COPY docker-entrypoint-init.d /docker-entrypoint-init.d
RUN chmod +x -R /docker-entrypoint-init.d

# Copy the user options file.
COPY user-options.cnf /root/.my.cnf

# Copy the MySQL configuration file.
COPY my.cnf /etc/mysql/my.cnf

# Configure the runtime environment of the container.
VOLUME /var/lib/mysql
WORKDIR /var/lib/mysql
EXPOSE 3306

# Set the entrypoint and default command.
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld_safe", "--user=mysql", "--console"]
