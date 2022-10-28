#! /bin/bash

# NTP setup

mv /tmp/ntp.conf /etc/ntp.conf
echo -e " server $(nslookup ntp.srcs_inception | grep 172 | awk '{print $2}') iburst" >> /etc/ntp.conf
service ntp restart
nginx -g "daemon off;"
