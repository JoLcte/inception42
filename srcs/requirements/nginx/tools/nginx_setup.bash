#! /bin/bash

# NTP setup
if [ ! -f "/etc/ntp.conf.backup" ]; then
	cp /etc/ntp.conf /etc/ntp.conf.backup
	mv /tmp/ntp.conf /etc/ntp.conf
fi

echo -e " server $(nslookup ntp.srcs_inception | grep 172 | awk '{print $2}') iburst" >> /etc/ntp.conf
service ntp restart
nginx -g "daemon off;"
