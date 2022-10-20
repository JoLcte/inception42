FROM debian:buster

RUN apt-get update -y && \
	apt-get install wget -y && \
	apt-get install php7.3 -y \
	php-fpm \
	php-mysql \
	sudo \
	mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.0.2-fr_FR.tar.gz -P /var/www/html
RUN cd /var/www/html && tar -xzf wordpress-6.0.2-fr_FR.tar.gz && rm wordpress-6.0.2-fr_FR.tar.gz

COPY ./conf/php.conf	/etc/php/7.3/fpm/pool.d/www.conf

# wp-config.php setup through a CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chown -R www-data:www-data /var/www/html/wordpress

COPY --chmod=755 ./tools/wp_setup.bash	/wp_setup.bash

ENTRYPOINT ["./wp_setup.bash"]
