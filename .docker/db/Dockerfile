FROM wodby/drupal-mariadb
MAINTAINER tess@ten7.com

COPY additional-dbs.sh /docker-entrypoint-initdb.d/additional-dbs.sh
RUN chmod +x /docker-entrypoint-initdb.d/additional-dbs.sh

COPY auto-import.sh /docker-entrypoint-initdb.d/auto-import.sh
RUN chmod +x /docker-entrypoint-initdb.d/auto-import.sh

COPY environment.sh /docker-entrypoint-initdb.d/environment.sh
RUN chmod +x /docker-entrypoint-initdb.d/environment.sh

COPY my.cnf /etc/mysql/my.cnf
