#! /bin/sh

# To make sure mariaDB has time to launch
sleep 10

if [! -e /var/www/wordpress/wp-config.php]; then
	wp config create --allow-root \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3306 \
	--path='/var/www/wordpress'

wp core install --url=$DOMAIN_NAME \
	 --title=$WP_TITLE \
	--admin_user=$ADMIN_USER \
	--admin-password=$ADMIN_PASSWORD \
	--admin-email=$ADMIN_EMAIL \
	--path='var/www/wordpress'

wp user create --allow-root \
	$USER_NAME \
	$USER_EMAIL \
	--role=author \
	--user_pass=$USER_PASSWORD \
	--path='var/www/wordpress' \
	>> /log.txt
fi

# PHP error handle in case /run/php does not exist
if [! -d /run/php ]; then
	mkdir ./run/php
fi

# Launch php-fpm
/usr/sbin/php-fpm7.3 -F
