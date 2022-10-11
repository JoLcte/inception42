# ----- COLORS -----
ON_BLUE = \033[44m
ON_CYAN = \033[46m
ON_GREEN = \033[42m
ON_PURPLE = \033[45m
BBLUE = \033[1;34m
BCYAN = \033[1;36m
BGREEN = \033[1;32m
BLUE = \033[0;34m
CYAN = \033[0;36m
PURPLE = \033[0;35m
EOC = \033[m
# ------------------

all: hosts

host:
	@echo "$(ON_GREEN)- Modifying hosts file... -$(EOC)"
	@sudo sed -i "s/localhost/jlecomte.42.fr/g" /etc/hosts
run:
	@echo "$(ON_GREEN)- Running inception ... -$(EOC)"
	@docker-compose -f ./srcs/docker-compose.yml up --build

images:
	@echo "$(ON_BLUE)- Docker Images List: -$(EOC)"
	@docker images

ps:
	@echo "$(ON_PURPLE)- Docker Containers List: -$(EOC)"
	@docker ps -a

rm:
	@echo "$(ON_PURPLE)- Removing all containers... -$(EOC)"
	@docker rm $$(docker ps -a -q)
 
rmi:
	@echo "$(ON_BLUE)- Removing all images... -$(EOC)"
	@docker rmi $$(docker images -q)
	

clean: rm

fclean: clean rmi

re: fclean all

.PHONY: all clean fclean re rmi rm ps images host
