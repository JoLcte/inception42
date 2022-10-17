#! /bin/sh

# To make sure mariaDB has time to launch
sleep 10

wp config create --allow-root \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3306 \
	--path='/var/www/html/wordpress'

wp core install --url=$DOMAIN_NAME \
	 --title=$WP_TITLE \
	--admin_user=$ADMIN_USER \
	--admin_password=$ADMIN_PASSWORD \
	--admin_email=$ADMIN_EMAIL \
	--path='var/www/html/wordpress'

wp user create --allow_root \
	$USER_NAME \
	$USER_EMAIL \
	--role=author \
	--user_pass=$USER_PASSWORD \
	--path='var/www/html/wordpress'

# PHP error handle in case /run/php does not exist
mkdir /run/php

# Launch php-fpm
/usr/sbin/php-fpm7.3 -FR
