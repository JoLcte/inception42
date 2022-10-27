#! /bin/bash

# NTP setup
if [ ! -f "/etc/ntp.conf.backup" ]; then
	cp /etc/ntp.conf /etc/ntp.conf.backup
	mv /tmp/ntp.conf /etc/ntp.conf
	cat /var/ntp/ip_cmd >> /etc/ntp.conf
fi

service ntp restart
nginx -g "daemon off;"
