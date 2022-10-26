#! /bin/bash

if [ ! f " /etc/php/7.3/fpm/pool.d/www.conf.backup" ]; then
	cp /etc/php/7.3/fpm/pool.d/www.conf /etc/php/7.3/fpm/pool.d/www.conf.backup
	mv /tmp/php.conf /etc/php/7.3/fpm/pool.d/www.conf
fi

if [ ! -f "/var/www/html/adminer/index.php" ]; then
	mkdir var/www/html/adminer
	wget http://www.adminer.org/latest.php -O /var/www/html/adminer/index.php
fi

if [ ! -d /run/php ]; then
	mkdir /run/php
fi

/usr/sbin/php-fpm7.3 --nodaemonize
