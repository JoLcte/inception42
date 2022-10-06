all: build run

build:
	sudo docker build -t nginx .

run:
	sudo docker run -p 443:443 -d --name nginx nginx

rm:
	@sudo docker stop nginx || true
	@sudo docker rm nginx || true

rmi:
	@sudo docker rmi nginx || true

rmi_all:
	@sudo docker rmi $$(sudo docker images -q) || true

bash:
	@sudo docker exec -it nginx bash

fclean: rm rmi

ffclean: rm rmi_all

re: fclean all

images:
	@sudo docker images

ps: 
	@sudo docker ps -a 
