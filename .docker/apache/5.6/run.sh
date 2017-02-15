#!/bin/sh

mkdir -p /run/apache2
mkdir -p /var/www/html

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

echo "Starting apache..."
/usr/sbin/httpd -D FOREGROUND -f /etc/apache2/httpd.conf
