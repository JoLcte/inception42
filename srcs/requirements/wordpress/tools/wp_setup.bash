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
	sudo -u www-data wp config create \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=$SQL_HOST:$SQL_PORT \
	--path='/var/www/html/wordpress'

	sudo -u www-data wp core install \
	--url=$DOMAIN_NAME \
	--title=$WP_TITLE \
	--admin_user=$ADMIN_USER \
	--admin_password=$ADMIN_PASSWORD \
	--admin_email=$ADMIN_EMAIL \
	--path='/var/www/html/wordpress'

	sudo -u www-data wp user create \
	$USER_NAME \
	$USER_MAIL \
	--role=author \
	--user_pass=$USER_PASSWORD \
	--path='/var/www/html/wordpress'

	# For Redis Bonus Service
	cd /var/www/html/wordpress
	sudo -u www-data wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME
	sudo -u www-data wp config set WP_REDIS_HOST $REDIS_HOST
	sudo -u www-data wp config set WP_REDIS_PORT $REDIS_PORT
	sudo -u www-data wp plugin install redis-cache --activate --path='/var/www/html/wordpress' -> already activated and installed
	sudo -u www-data wp plugin update --all --path='/var/www/html/wordpress' -> already updated
fi

# PHP error handle in case /run/php does not exist
if [ ! -d /run/php ]; then
	mkdir /run/php
fi

# Launch redis
sudo -u www-data wp redis enable --path='/var/wwww/html/wordpress'

# Launch php-fpm
/usr/sbin/php-fpm7.3 -FR
