#!/bin/sh

mkdir -p /run/apache2
mkdir -p /var/www/html

echo "Clearing any old processes..."
rm -f /run/apache2/apache2.pid
echo "Starting apache..."
/usr/sbin/httpd -D FOREGROUND -f /etc/apache2/httpd.conf
