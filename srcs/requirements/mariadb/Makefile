all: build run

build:
	sudo docker build -t mariadb .

run:
	sudo docker run -it --name mariadb mariadb

rm:
	@sudo docker stop mariadb || true
	@sudo docker rm mariadb || true

rmi:
	@sudo docker rmi mariadb || true

rmi_all:
	@sudo docker rmi $$(sudo docker images -q) || true

bash:
	@sudo docker exec -it mariadb bash

fclean: rm rmi

ffclean: rm rmi_all

re: fclean all

images:
	@sudo docker images

ps: 
	@sudo docker ps -a 
