#!/bin/sh

mkdir -p /run/apache2
mkdir -p /var/www/html

# Allow the Apache docroot to be overridden.
APACHE_DOCROOT_DIR="${APACHE_DOCROOT_DIR:-/var/www/html}"
if [ -n "$APACHE_DOCROOT_DIR" ]; then
     sed -i 's@^\s*<Directory.*@'"   <Directory \"${APACHE_DOCROOT_DIR}\">"'@' /etc/apache2/sites.d/000_default.conf
fi

# Allow key PHP variables to be overriden.
PHP_XDEBUG_ENABLED="${PHP_XDEBUG_ENABLED:-0}"
PHP_XDEBUG_AUTOSTART="${PHP_XDEBUG_AUTOSTART:-0}"
PHP_XDEBUG_REMOTE_CONNECT_BACK="${PHP_XDEBUG_REMOTE_CONNECT_BACK:-0}"
PHP_XDEBUG_STDOUT_LOGS="${PHP_XDEBUG_STDOUT_LOGS:-0}"
PHP_XDEBUG_PROFILE_FORCE="${PHP_XDEBUG_PROFILE_FORCE:-0}"

# Delete the xdebug logs from the previous container run.
if [ -e "/var/log/apache2/xdebug.log" ]; then
  rm /var/log/apache2/xdebug.log
fi

if [ -n "$PHP_SENDMAIL_PATH" ]; then
     sed -i 's@^;sendmail_path.*@'"sendmail_path = ${PHP_SENDMAIL_PATH}"'@' /etc/php5/php.ini
fi

if [ "$PHP_XDEBUG_ENABLED" -eq "1" ]; then
     sed -i 's/^;zend_extension.*/zend_extension = xdebug.so/' /etc/php5/conf.d/xdebug.ini
fi

if [ "$PHP_XDEBUG_AUTOSTART" -eq "0" ]; then
     sed -i 's/^xdebug.remote_autostart.*/xdebug.remote_autostart = 0/' /etc/php5/conf.d/xdebug.ini
fi

if [ "$PHP_XDEBUG_REMOTE_CONNECT_BACK" -eq "0" ]; then
     sed -i 's/^xdebug.remote_connect_back.*/xdebug.remote_connect_back = 0/' /etc/php5/conf.d/xdebug.ini
fi

if [ -n "$PHP_XDEBUG_REMOTE_HOST" ]; then
     sed -i 's/^xdebug.remote_host.*/'"xdebug.remote_host = ${PHP_XDEBUG_REMOTE_HOST}"'/' /etc/php5/conf.d/xdebug.ini
fi

if [ -n "$PHP_XDEBUG_STDOUT_LOGS" -eq "1" ]; then
  ln -sfn /dev/stdout /var/log/apache2/xdebug.log
fi

if [ -n "$PHP_XDEBUG_PROFILE_TRIGGER" ]; then
     sed -i 's/^xdebug.profiler_enable_trigger_value =.*/'"xdebug.profiler_enable_trigger_value = ${PHP_XDEBUG_PROFILE_TRIGGER}"'/' /etc/php5/conf.d/xdebug.ini
fi

if [ "$PHP_XDEBUG_PROFILE_FORCE" -eq "1" ]; then
     sed -i 's/^xdebug.profiler_enable =.*/xdebug.profiler_enable = 1/' /etc/php5/conf.d/xdebug.ini
fi

echo "Starting apache..."
/usr/sbin/httpd -D FOREGROUND -f /etc/apache2/httpd.conf
