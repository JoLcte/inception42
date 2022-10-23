#! /bin/bash

if [ ! =f "/etc/vsftpd/vsftpd.conf.backup" ]; then
	
	cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.backup
	mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

# Add user FTP_ADMIN

	#create user w/o prompt for password
	adduser $FTP_ADMIN --disabled-password
	#change empty password to actual password
	echo "$FTP_ADMIN:$FTP_ADMIN_PWD" | /usr/sbin/chpasswd
	# change rights on wp directory for this user
	echo $FTP_ADMIN | tee -a/etcvsftpd.userlist

# ADD user FTP_USER and put it in jail
	
	adduser $FTP_USER --disabled-password
	echo "$FTP_USER:$FTP_USER_PWD" | /usr/sbin/chpasswd
	echo $FTP_USER | tee -a/etcvsftpd.userlist
	#put FTP_USER in chroot_list
	echo $FTP_USER | tee -a/etcvsftpd.chroot_list
 # ... TO BE CONTINUED

