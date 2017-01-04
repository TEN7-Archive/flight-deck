FROM wodby/drupal-mariadb
MAINTAINER tess@ten7.com

COPY auto-import.sh /docker-entrypoint-initdb.d/auto-import.sh
RUN chmod +x /docker-entrypoint-initdb.d/auto-import.sh

COPY my.cnf /etc/mysql/my.cnf
