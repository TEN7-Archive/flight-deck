FROM alpine
MAINTAINER tess@ten7.com

RUN apk update && \
    apk add --no-cache \
            apache2 \
            php5-apache2 \
            curl \
            php5-cli \
            php5-mcrypt \
            php5-gd \
            php5-json \
            php5-phar \
            php5-openssl \
            php5-pdo \
            php5-pdo_mysql \
            php5-pdo_sqlite \
            php5-xdebug \
            php5-dom \
            php5-xml \
    && rm -f /var/cache/apk/*

# Need Imagemagik, drush, compass

# RUN usermod -u 1000 apache

COPY httpd.conf /etc/apache2/httpd.conf

COPY run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

EXPOSE 80

CMD ["/scripts/run.sh"]
