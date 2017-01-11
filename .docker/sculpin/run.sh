#!/bin/sh

CWD=`pwd`

cd /var/www/html
composer install

./vendor/bin/sculpin generate --watch --server

cd $CWD
