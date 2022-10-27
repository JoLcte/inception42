#! /bin/bash

if [ ! -f "/etc/ntp.conf.backup" ]; then
	cp /etc/ntp.conf /etc/ntp.conf.backup
	mv /tmp/ntp.conf /etc/ntp.conf
	echo -n "server " > /var/ntp/ip_cmd
	hostname -I  | tr '\n' ' ' >> /var/ntp/ip_cmd
	echo "iburst" >> /var/ntp/ip_cmd
	
fi

exec /usr/sbin/ntpd -d -f /etc/ntp.conf

