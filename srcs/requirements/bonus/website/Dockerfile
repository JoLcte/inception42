FROM	debian:buster

RUN	apt update && apt install -y nodejs npm

ADD ./tools/index.html .
ADD ./tools/site.js .
CMD node norminet.js
