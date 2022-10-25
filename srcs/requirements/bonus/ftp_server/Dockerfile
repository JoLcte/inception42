FROM 	debian:buster

RUN	apt update && apt install -y vsftpd 

COPY	./conf/vsftpd.conf /tmp/vsftpd.conf
COPY	--chmod=755 ./tools/ftp_setup.bash /ftp_setup.bash

# Because we don't know why it's not already there
RUN	mkdir -p /var/empty

# SSL
RUN	openssl req -new -x509 -sha256 -days 365 -nodes \
	-out /etc/ssl/private/vsftpd.cert.pem \
	-keyout /etc/ssl/private/vsftpd.key.pem \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=jlecomte.42.fr/UID=jlecomte"

# Changing rights for the SSL certificate only rw for root
RUN	chmod 600 /etc/ssl/private/vsftpd.cert.*

ENTRYPOINT	["./ftp_setup.bash"] 

# For testing
#CMD tail -f
