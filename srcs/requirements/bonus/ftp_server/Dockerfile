FROM 	debian:buster

RUN	apt update && apt install vsftpd -y 

COPY	./conf/vsftpd.conf /tmp/vsftpd.conf
COPY	--chmod=755 ./tools/ftp_setup.bash /ftp_setup.bash

# SSL
RUN	openssl req -new -x509 -sha256 -days 365 -nodes \
	-out /etc/ssl/private/vsftpd.cert.pem \
	-keyout /etc/ssl/private/vsftpd.key.pem \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=jlecomte.42.fr/UID=jlecomte"

# utilite HAS TO BE CHECKED
#RUN	chown root:root /etc/ssl/private/vsftpd.cert.*
#RUN	chmod 600 /etc/ssl/private/vsftpd.cert.*

ENTRYPOINT	["./ftp_setup.bash"] 

# For testing
#CMD tail -f
