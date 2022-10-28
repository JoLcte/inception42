#! /bin/bash

if [ ! -f "/etc/ntp.conf.backup" ]; then
	cp /etc/ntp.conf /etc/ntp.conf.backup
	mv /tmp/ntp.conf /etc/ntp.conf
	echo -e "broadcast $(ip addr | grep eth0 | grep brd | awk '{print $4}')" >> /etc/ntp.conf
fi

exec /usr/sbin/ntpd -d -f /etc/ntp.conf

