FROM	debian:buster

COPY	./conf/ntp.conf /tmp/.
COPY	--chmod=755 ./tools/ntp_setup.bash /
RUN	apt update -y && apt install -y ntp


ENTRYPOINT ["./ntp_setup.bash"]
