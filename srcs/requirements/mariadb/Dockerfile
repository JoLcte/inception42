FROM debian:buster

RUN apt-get update -y && \
	apt-get install mariadb-server -y && \
	apt-get install net-tools -y

COPY conf/50-server.cnf		/etc/mysql/mariadb.conf.d/50-server.cnf
COPY --chmod=755 tools/db_setup.bash		/db_setup.bash

ENTRYPOINT ["./db_setup.bash"]
