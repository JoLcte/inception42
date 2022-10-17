#! /bin/sh

# To make sure mariaDB has time to launch
sleep 10

if [! -e /var/www/wordpress/wp-config.php]; then
	wp config create \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3306 \
	--path='/var/www/html/wordpress'

wp core install --url=$DOMAIN_NAME \
	 --title=$WP_TITLE \
	--admin_user=$ADMIN_USER \
	--admin-password=$ADMIN_PASSWORD \
	--admin-email=$ADMIN_EMAIL \
	--path='var/www/html/wordpress'

wp user create \
	$USER_NAME \
	$USER_EMAIL \
	--role=author \
	--user_pass=$USER_PASSWORD \
	--path='var/www/html/wordpress' \
	>> /log.txt
fi

# PHP error handle in case /run/php does not exist
if [! -d /run/php ]; then
	mkdir /run/php
fi

# Launch php-fpm
/usr/sbin/php-fpm7.3 -FR
