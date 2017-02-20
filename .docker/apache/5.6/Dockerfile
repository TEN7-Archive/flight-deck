FROM alpine
MAINTAINER tess@ten7.com

# Install Apache and PHP.
RUN apk -U upgrade

RUN apk add --update --no-cache \
            zlib \
            apache2 \
            php5-apache2 \
            curl \
            git \
            php5-curl \
            php5-cli \
            php5-mcrypt \
            php5-gd \
            php5-json \
            php5-phar \
            php5-openssl \
            php5-pdo \
            php5-pdo_mysql \
            php5-pdo_sqlite \
            php5-mysql \
            php5-mysqli \
            php5-xdebug \
            php5-dom \
            php5-xml \
            php5-ctype \
            php5-imagick \
            php5-ldap \
            php5-opcache \
            php5-memcache \
            php5-sockets \
            mariadb-client \
    && rm -f /var/cache/apk/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install drush
RUN composer global require drush/drush && \
    ln -s /root/.composer/vendor/bin/drush /usr/bin/drush

# Install compass. We uninstall build dependencies afterwards to save space.
RUN apk add --update build-base libffi-dev ruby ruby-dev \
        && gem install sass compass --no-ri --no-rdoc \
        && apk del build-base libffi-dev ruby-dev \
        && rm -rf /var/cache/apk/*

# Copy the Apache configuration files.
COPY httpd.conf /etc/apache2/httpd.conf
COPY 000_default.conf /etc/apache2/sites.d/

# Copy PHP configuration files.
COPY php.ini /etc/php5/
COPY opcache.ini /etc/php5/conf.d/
COPY xdebug.ini /etc/php5/conf.d/

# Add and chmod our run scripts.
COPY run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

EXPOSE 80

WORKDIR /var/www/html

CMD ["/scripts/run.sh"]
