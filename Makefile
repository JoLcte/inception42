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

YAML = srcs/docker-compose.yml

all: host up


ifeq (debug,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "debug"
  DEBUG_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(DEBUG_ARGS):;@:)
endif

debug:
	docker compose -f $(YAML) exec $(DEBUG_ARGS) bash



startfresh: stop0 rm rmi 
	@echo "$(ON_PURPLE)- Removing all existing volumes... -$(EOC)"
	@docker volume rm $$(docker volume ls -q) 2> /dev/null || true
	@echo "$(BCYAN)---> Volumes removing: [DONE]$(EOC)"
	@echo "$(ON_PURPLE)- Removing all networks... -$(EOC)"
	@docker network rm $$(docker network ls -q) 2> /dev/null || true
	@echo "$(BCYAN)---> Networks removing: [DONE]$(EOC)"

host:
	@echo "$(ON_PURPLE)- Modifying hosts file... -$(EOC)"
	@if ! grep -q "jlecomte.42.fr" /etc/hosts; then sudo sh -c 'echo "127.0.0.1\tjlecomte.42.fr" >> /etc/hosts'; fi
	@if ! grep -q "jlecomte.42.fr" /etc/hosts; then echo "$(BCYAN)WARNING: Host hasn't been modified$(EOC)";\
		else echo "$(BCYAN)Host modifed: [OK]$(EOC)"; fi

up:
	@echo "$(ON_GREEN)- Running Inception ... -$(EOC)"
	@docker compose -f $(YAML) up -d --build
	@echo "$(BCYAN)---> Inception running: [DONE]$(EOC)"

images:
	@echo "$(ON_BLUE)- Docker Images List: -$(EOC)"
	@docker images

ps:
	@echo "$(ON_PURPLE)- Docker Containers List: -$(EOC)"
	@docker ps -a

volumes:
	@echo "$(ON_PURPLE)- Docker Volumes List: -$(EOC)"
	@docker volume ls

rm:
	@echo "$(ON_PURPLE)- Removing all containers... -$(EOC)"
	@docker rm $$(docker ps -aq) 2> /dev/null || true
	@echo "$(BCYAN)---> Inception containers removing: [DONE]$(EOC)"
 
rmi:
	@echo "$(ON_BLUE)- Removing all images... -$(EOC)"
	@docker rmi -f $$(docker images -aq) 2> /dev/null || true
	@echo "$(BCYAN)---> Images removing: [DONE]$(EOC)"
	
stop: 
	@echo "$(ON_GREEN)- Stopping Inception... -$(EOC)"
	@docker compose -f $(YAML) stop
	@echo "$(BCYAN)---> Inception stopped: [OK]$(EOC)"

down: 
	@echo "$(ON_GREEN)- Putting down Inception... -$(EOC)"
	@docker compose -f $(YAML) down
	@echo "$(BCYAN)---> Putting Inception down: [OK]$(EOC)"

stop0:
	@echo "$(ON_PURPLE)- Stopping all containers... -$(EOC)"
	@docker stop $$(docker ps -aq) 2> /dev/null || true
	@echo "$(BCYAN)---> All containers stopped: [OK]$(EOC)"

clean: stop
	@docker compose down -f $(YAML) --volumes 2> /dev/null || true
	@echo "$(BCYAN)Inception containers, networks and volumes removed: [OK]$(EOC)"

fclean: clean 
	@echo "$(ON_GREEN)- Wiping out every traces of Inception... -$(EOC)"
	@docker system prune -a --volumes -f
	@echo "$(BCYAN)No more inception: [DONE]$(EOC)"
	

re: fclean all

.PHONY: first all clean fclean re rmi rm ps images host stop stop0 run start volumes
