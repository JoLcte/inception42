# Specify the parent image from which we build
FROM debian:buster

# Set the working directory
#WORKDIR


# OS Setup for next steps
RUN	apt-get update && apt-get -y upgrade && \
	apt-get install -y nginx vim curl openssl

# TLS certificates setup
RUN	mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=jlecomte.42.fr/UID=jlecomte"

# Configuration files handle
RUN	mkdir -p /var/run/nginx
COPY	conf/nginx.conf /etc/nginx/nginx.conf

# Ports
EXPOSE 443:443
