FROM alpine:3.5
MAINTAINER tess@ten7.com

# Create a apache user with the home directory.
RUN adduser -g apache -D -h /var/www apache && \
    mkdir -p -m 774 /var/www && \
    chown apache:apache -R /var/www

# Install Apache and PHP.
RUN apk -U upgrade

RUN apk add --update --no-cache \
            ansible \
            py-mysqldb \
            bash \
            libcap \
            zlib \
            apache2 \
            php5-apache2 \
            curl \
            git \
            patch \
            php5-cli \
            php5-curl \
            php5-ctype \
            php5-dom \
            php5-gd \
            php5-iconv \
            php5-imagick \
            php5-json \
            php5-ldap \
            php5-mcrypt \
            php5-memcache \
            php5-mysql \
            php5-mysqli \
            php5-opcache \
            php5-openssl \
            php5-pdo \
            php5-pdo_mysql \
            php5-pdo_sqlite \
            php5-pdo_dblib \
            php5-phar \
            php5-soap \
            php5-sockets \
            php5-xdebug \
            php5-xml \
            php5-zlib \
            mariadb-client \
            rsync \
            openssh-client \
    && rm -rf /tmp/* \
    && rm -f /var/cache/apk/*

# Allow Apache to allocate ports as non-root.
RUN setcap cap_net_bind_service=+ep /usr/sbin/httpd

# Chown the /etc/mysql directory so we can change my.cnf settings.
RUN mkdir -p -m 774 \
      /run/apache2 \
      /etc/apache2/sites.d && \
    chown -R apache:apache \
      /etc/apache2 \
      /etc/apache2/sites.d \
      /etc/php5 \
      /run/apache2 \
      /var/log/apache2 \
      /var/www

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log && \
    ln -sf /dev/stdout /var/log/apache2/000_default-access_log && \
    ln -sf /dev/stderr /var/log/apache2/000_default-error_log

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install drush
ADD https://github.com/drush-ops/drush/archive/7.4.0.tar.gz /tmp/drush.tar.gz
RUN mkdir -p -m 776 /usr/local/share/drush && \
    tar --strip-components=1 -xzf /tmp/drush.tar.gz -C /usr/local/share/drush && \
    cd /usr/local/share/drush && \
    composer install --prefer-dist --no-interaction && \
    chmod -R a+xr /usr/local/share/drush && \
    ln -sfn /usr/local/share/drush/drush /usr/local/bin/drush

# Install sass. We uninstall build dependencies afterwards to save space.
RUN apk add --update build-base libffi-dev ruby ruby-dev \
        && gem install sass compass sass-globbing --no-ri --no-rdoc \
        && apk del build-base libffi-dev ruby-dev \
        && rm -rf /var/cache/apk/*

# Copy the Apache configuration files.
COPY httpd.conf /etc/apache2/httpd.conf
COPY 000_default.conf /etc/apache2/sites.d/

# Copy PHP configuration files.
COPY php.ini /etc/php5/
COPY opcache.ini /etc/php5/conf.d/
COPY xdebug.ini /etc/php5/conf.d/

# Copy Drush configuration files.
COPY drushrc.php /etc/drush/
COPY aliases.drushrc.php /etc/drush/

# Copy various key scripts to a directory in $PATH.
COPY docker-entrypoint.sh /usr/local/bin/
COPY vim.sh /usr/local/bin/vim

# Make them all executable.
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh && \
    chmod a+x /usr/local/bin/vim

# Copy the entire contents of the init.d directory.
COPY docker-entrypoint-init.d /docker-entrypoint-init.d
RUN chmod a+x -R /docker-entrypoint-init.d

# Copy the root bashrc file.
COPY bashrc-root /root/.bashrc

EXPOSE 80
WORKDIR /var/www
USER apache

# Copy the user bashrc file.
COPY bashrc-user /var/www/.bashrc

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND", "-f", "/etc/apache2/httpd.conf"]
