#! /bin/bash

if [ ! -f "/etc/vsftpd.conf.backup" ]; then
	
	cp /etc/vsftpd.conf /etc/vsftpd.conf.backup
	mv /tmp/vsftpd.conf /etc/vsftpd.conf

# Add user FTP_ADMIN (not in jail for example but should be)

	#create user w/o prompt for password
	adduser $FTP_ADMIN --disabled-password --gecos ""
	#change empty password to actual password
	echo "$FTP_ADMIN:$FTP_ADMIN_PWD" | /usr/sbin/chpasswd
	# add FTP_ADMIN to the userlist
	echo $FTP_ADMIN | tee -a /etc/vsftpd.userlist
	# add FTP_ADMIN to www-data group
	usermod -a -G www-data $FTP_ADMIN

# ADD user FTP_USER and put it in jail
	
	adduser $FTP_USER --disabled-password --gecos ""
	echo "$FTP_USER:$FTP_USER_PWD" | /usr/sbin/chpasswd
	echo $FTP_USER | tee -a /etc/vsftpd.userlist
	#put FTP_USER in chroot_list
	echo $FTP_USER | tee -a /etc/vsftpd.chroot_list
	usermod -a -G www-data $FTP_USER
	
fi

echo "FTP started on :21"
/usr/sbin/vsftpd /etc/vsftpd.conf
