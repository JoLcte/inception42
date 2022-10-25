FROM	debian:buster

RUN	apt-get update -y && apt install -y wget

RUN wget http://www.adminer.org/latest.php -O /var/www/html/adminer.php

RUN chown -R www-data:www-data /var/www/html/adminer.php
RUN chmod 755 /var/www/html/adminer.php

