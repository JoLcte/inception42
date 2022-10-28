FROM	debian:buster

RUN	apt update && apt install -y nodejs npm

COPY ./tools/index.html /
COPY ./tools/norminet.js /

CMD node norminet.js
