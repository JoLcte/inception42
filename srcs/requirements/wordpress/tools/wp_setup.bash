#! /bin/bash

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
	
	# To make sure mariaDB has time to launch
	
	i=0
	while ! mariadb -h$SQL_HOST -u$SQL_USER -p$SQL_PASSWORD
	do
		((++i))
		sleep 1
		echo -e "$i Wordpress failed to connect to MariaDB"
		if [[ i -eq 30 ]]
		then
			exit -1
		fi
	done
	wp config create --allow-root \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=$SQL_HOST:$SQL_PORT \
	--path='/var/www/html/wordpress'

	wp core install --allow-root --url=$DOMAIN_NAME \
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
fi

# PHP error handle in case /run/php does not exist
if [ ! -d /run/php ]; then
	mkdir /run/php
fi

# Launch php-fpm
/usr/sbin/php-fpm7.3 -FR
