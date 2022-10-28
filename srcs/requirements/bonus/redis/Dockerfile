FROM debian:buster

RUN apt-get update -y && \
	apt-get install redis-server -y && \
	apt-get install php-redis -y

COPY --chmod=640 ./conf/redis.conf	/etc/redis/redis.conf
RUN service redis-server restart

CMD ["redis-server", "--protected-mode", "no"]
