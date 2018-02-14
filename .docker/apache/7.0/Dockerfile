FROM alpine:3.6
MAINTAINER tess@ten7.com

# Update all the Alpine packages.
RUN apk -U upgrade

# Install Apache and PHP.
RUN apk add --update --no-cache \
            ansible \
            bash \
            zlib \
            apache2 \
            php7-apache2 \
            php7 \
            git \
            patch \
            curl \
            php7-ctype \
            php7-curl \
            php7-dom \
            php7-gd \
            php7-json \
            php7-ldap \
            php7-mbstring \
            php7-mcrypt \
            php7-memcached \
            php7-mysqlnd \
            php7-opcache \
            php7-openssl \
            php7-phar \
            php7-sqlite3 \
            php7-pdo \
            php7-pdo_mysql \
            php7-pdo_sqlite \
            php7-phar \
            php7-soap \
            php7-session \
            php7-simplexml \
            php7-tokenizer \
            php7-xdebug \
            php7-exif \
            php7-xml \
            php7-xmlwriter \
            php7-zip \
            php7-zlib \
            mariadb-client \
            rsync \
            openssh-client \
            nodejs-npm \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log && \
    ln -sf /dev/stdout /var/log/apache2/000_default-access_log && \
    ln -sf /dev/stderr /var/log/apache2/000_default-error_log

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install drush
RUN composer global require drush/drush && \
    ln -s /root/.composer/vendor/bin/drush /usr/bin/drush

# Install Drupal console
RUN curl https://drupalconsole.com/installer -L -o /usr/bin/drupal && \
    chmod 777 /usr/bin/drupal

# Install compass. We uninstall build dependencies afterwards to save space.
# RUN apk add --update build-base libffi-dev ruby ruby-dev \
#         && gem install sass compass sass-globbing --no-ri --no-rdoc \
#         && apk del build-base libffi-dev ruby-dev \
#         && rm -rf /var/cache/apk/*

# Copy the Apache configuration files.
COPY httpd.conf /etc/apache2/httpd.conf
COPY 000_default.conf /etc/apache2/sites.d/

# Copy PHP configuration files.
COPY php.ini /etc/php7/
COPY 00_opcache.ini /etc/php7/conf.d/00_opcache.ini
COPY xdebug.ini /etc/php7/conf.d/xdebug.ini

# Copy Drush configuration files.
COPY drushrc.php /etc/drush/
COPY aliases.drushrc.php /etc/drush/

# Copy various key scripts to a directory in $PATH.
COPY docker-entrypoint.sh /usr/local/bin/
COPY vim.sh /usr/local/bin/vim

# Make them all executable.
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh && \
    chmod +x /usr/local/bin/vim

# Copy the entire contents of the init.d directory.
COPY docker-entrypoint-init.d /docker-entrypoint-init.d
RUN chmod a+x -R /docker-entrypoint-init.d

EXPOSE 80
WORKDIR /var/www/html

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND", "-f", "/etc/apache2/httpd.conf"]
