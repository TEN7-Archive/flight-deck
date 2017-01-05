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

# Install compass. We uninstall build dependencies afterwards to save space.
RUN apk add --update build-base libffi-dev ruby ruby-dev \
        && gem install sass compass --no-ri --no-rdoc \
        && apk del build-base libffi-dev ruby-dev \
        && rm -rf /var/cache/apk/*

# Copy the Apache configuration file.
COPY httpd.conf /etc/apache2/httpd.conf

# Copy the PHP configuration file.
COPY php.ini /etc/php7/php.ini

# Add and chmod our run scripts.
COPY run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

EXPOSE 80

CMD ["/scripts/run.sh"]
