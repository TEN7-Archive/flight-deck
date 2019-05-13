FROM alpine:3.9
MAINTAINER tess@ten7.com

# Create a flightdeck user with the home directory.
RUN addgroup -g 1000 flightdeck && \
    adduser -u 1000 -G flightdeck -D -h /var/www -s /bin/bash flightdeck && \
    addgroup flightdeck cron &&  \
    mkdir -p -m 774 /var/www && \
    chown flightdeck:flightdeck -R /var/www

# Update all the Alpine packages.
RUN apk -U upgrade

# Install Apache and PHP.
RUN apk add --update --no-cache \
            ansible \
            py2-pip \
            bash \
            busybox-suid \
            libcap \
            zlib \
            php7 \
            git \
            patch \
            curl \
            php7-ctype \
            php7-curl \
            php7-dom \
            php7-fileinfo \
            php7-gd \
            php7-iconv \
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
            supervisor \
            openssh \
            openssh-client \
            nodejs-npm \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

# Install Python 3 dependencies from pip
RUN pip3 install passlib PyMySQL

# Chown the flightdeck user directory and create needed cron directories
RUN mkdir -p -m 774 \
      /etc/periodic \
      /etc/crontabs \
      /var/spool/cron \
      /var/log/cron \
      /var/www/.ssh \
      /var/www/.drush \
      /var/www/.drush/sites \
      /var/www/.npm-global \
    && \
    chown -R flightdeck:flightdeck \
      /var/www \
      /var/www/.ssh \
      /var/www/.drush \
      /var/www/.drush/sites \
      /var/www/.npm-global

# Forward cron logs to docker log collector
RUN ln -sf /dev/stdout /var/log/cron/cron.log

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install Drupal console
RUN curl https://drupalconsole.com/installer -L -o /usr/bin/drupal && \
    chmod 777 /usr/bin/drupal

# Install passlib and aws cli from pip as apk versions are in testing.
RUN pip install awscli

# Copy PHP configuration files.
COPY php.ini /etc/php7/
COPY 00_opcache.ini /etc/php7/conf.d/00_opcache.ini
COPY xdebug.ini /etc/php7/conf.d/xdebug.ini

# Copy other configuration files.
COPY supervisord.conf  /etc/supervisord.conf
COPY sshd_config  /etc/ssh/sshd_config
COPY motd.txt /etc/motd

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

# Switch to the ssh user to do additional setup.
USER flightdeck

# Copy the user bashrc file.
COPY --chown=flightdeck:flightdeck bashrc-user /var/www/.bashrc
COPY --chown=flightdeck:flightdeck bashrc-user /var/www/.bash_profile

# Install drush for the ssh user.
RUN composer global require consolidation/cgr && \
    /var/www/.composer/vendor/bin/cgr drush/drush:~9.5.2 && \
    /var/www/.composer/vendor/bin/drush core:init -y

# Set the dir for global node packages to be user-local.
RUN npm config set prefix '/var/www/.npm-global'

# Install dart-sass globally.
RUN npm install -g sass

# Switch back to root for sshd.
USER root

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord"]
