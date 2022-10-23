FROM debian:buster

RUN apt update && apt install vsftpd -y 
#RUN useradd --system ftp 2> /dev/null
#RUN service vsftpd reload

#COPY ./conf/vsftpd.conf /etc/vsftpd.conf

CMD tail -f
