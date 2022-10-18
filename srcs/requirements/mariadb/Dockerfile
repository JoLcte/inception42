FROM debian:buster

RUN apt-get update -y && \
	apt-get install mariadb-server -y && \
	apt-get install net-tools -y

COPY conf/50-server.cnf		/etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/run.sh		/run.sh

ENTRYPOINT ["bash", "run.sh"]

EXPOSE 3306
