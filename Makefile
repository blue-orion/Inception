NAME = inception

DOCKER_COMPOSE = docker-compose -f
SRC = srcs/docker-compose.yml
ENV_FILE = srcs/.env

.PHONY: all up down stop fclean re

all: up

up:
	$(DOCKER_COMPOSE) $(SRC) --env-file $(ENV_FILE) up --build -d

down:
	$(DOCKER_COMPOSE) $(SRC) down

stop:
	$(DOCKER_COMPOSE) $(SRC) stop

fclean: down
	docker rmi $(shell docker images -qa)
	docker volume rm $(shell docker volume ls -qf "name=wordpress_data") 2>/dev/null || true
	docker volume rm $(shell docker volume ls -qf "name=mariadb_data") 2>/dev/null || true

re: fclean all

