FROM alpine
MAINTAINER tess@ten7.com

# Install Apache and PHP.
RUN apk add --update --no-cache \
            apache2 \
            php7-apache2 \
            php7 \
            curl \
            php7-mcrypt \
            php7-gd \
            php7-json \
            php7-phar \
            php7-openssl \
            php7-pdo \
            php7-pdo_mysql \
            php7-pdo_sqlite \
            php7-xdebug \
            php7-dom \
            php7-mbstring \
            php7-xml \
            php7-ctype \
            php7-ldap \
          	php7-session \
            php7-opcache \
            php7-zlib \
            mariadb-client \
    && ln -s /usr/bin/php7 /usr/bin/php \
    && rm -f /var/cache/apk/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install drush
RUN composer global require drush/drush && \
    ln -s /root/.composer/vendor/bin/drush /usr/bin/drush

# Install Drupal console
RUN curl https://drupalconsole.com/installer -L -o /usr/bin/drupal && \
    chmod 777 /usr/bin/drupal

# Install compass. We uninstall build dependencies afterwards to save space.
RUN apk add --update build-base libffi-dev ruby ruby-dev \
        && gem install sass compass --no-ri --no-rdoc \
        && apk del build-base libffi-dev ruby-dev \
        && rm -rf /var/cache/apk/*

# Copy the Apache configuration files.
COPY httpd.conf /etc/apache2/httpd.conf
COPY 000_default.conf /etc/apache2/sites.d/

# Copy PHP configuration files.
COPY php.ini /etc/php7/
COPY 00_opcache.ini /etc/php7/conf.d/
COPY xdebug.ini /etc/php7/conf.d/

# Add and chmod our run scripts.
COPY run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

EXPOSE 80

WORKDIR /var/www/html

CMD ["/scripts/run.sh"]
