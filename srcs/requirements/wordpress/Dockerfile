FROM debian:buster

RUN apt-get update -y && \
	apt-get install wget -y && \
	apt-get install -y php7.3 \
	php-fpm \
	php-mysql

RUN wget https://fr.wordpress.org/wordpress-6.0.2-fr_FR.tar.gz -P /var/www/html
RUN cd /var/www/html && tar -xzf wordpress-6.0.2-fr_FR.tar.gz && rm wordpress-6.0.2-fr_FR.tar.gz

COPY ./conf/php.conf	/etc/php/7.3/fpm/pool.d/www.conf

# Giving root privileges to wordpress directory to be able to write
RUN chown -R root:root /var/www/html/wordpress

# wp-config.php setup through a CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/run.sh	/run.sh

ENTRYPOINT ["bash", "run.sh"]
