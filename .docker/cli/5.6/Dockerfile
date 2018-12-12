FROM alpine:3.5
MAINTAINER tess@ten7.com

# Install Apache and PHP.
RUN apk -U upgrade

RUN apk add --update --no-cache \
            ansible \
            py-mysqldb \
            py2-pip \
            bash \
            busybox-suid \
            libcap \
            zlib \
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
            supervisor \
            openssh \
            openssh-client \
    && rm -rf /tmp/* \
    && rm -f /var/cache/apk/*

# Create a flightdeck user with the home directory.
RUN addgroup -g 1000 flightdeck && \
    adduser -u 1000 -G flightdeck -D -h /var/www -s /bin/bash flightdeck && \
    addgroup flightdeck cron &&  \
    mkdir -p -m 774 /var/www && \
    chown flightdeck:flightdeck -R /var/www

# Chown the flightdeck user directory and create needed cron directories
RUN mkdir -p -m 774 \
      /etc/periodic \
      /etc/crontabs \
      /var/spool/cron \
      /var/log/cron && \
    chown -R flightdeck:flightdeck \
      /var/www

# Forward cron logs to docker log collector
RUN ln -sf /dev/stdout /var/log/cron/cron.log

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

# Install passlib and aws cli from pip as apk versions are in testing.
RUN pip install passlib awscli

# Copy PHP configuration files.
COPY php.ini /etc/php5/
COPY opcache.ini /etc/php5/conf.d/
COPY xdebug.ini /etc/php5/conf.d/

# Copy Drush configuration files.
COPY drushrc.php /etc/drush/
COPY aliases.drushrc.php /etc/drush/

# Copy Supervisor configuration files.
COPY supervisord.conf  /etc/supervisord.conf
COPY sshd_config  /etc/ssh/sshd_config

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

# Copy the Ansible configuration files
COPY ansible-hosts /etc/ansible/hosts
COPY ansible.cfg /etc/ansible/ansible.cfg

EXPOSE 22
WORKDIR /var/www

# Copy the user bashrc file.
COPY bashrc-user /var/www/.bashrc
COPY bashrc-user /var/www/.bash_profile

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord"]
