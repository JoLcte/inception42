FROM	debian:buster

RUN	apt-get update -y && apt install -y wget php7.3 php-fpm php-mysql

COPY	./conf/php.conf /tmp/.
COPY	--chmod=755 ./tools/adm_setup.bash /tmp/adm_setup.bash

ENTRYPOINT ["./tmp/adm_setup.bash"]
