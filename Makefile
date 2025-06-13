NAME = inception

DOCKER_COMPOSE = docker-compose -f
SRC = srcs/docker-compose.yml

all: up

up:
	$(DOCKER_COMPOSE) $(SRC) up --build -d

down:
	$(DOCKER_COMPOSE) $(SRC) down

stop:
	$(DOCKER_COMPOSE) $(SRC) stop

fclean: down
	docker volume rm $(shell docker volume ls -qf "name=wordpress_data") || true
	docker volume rm $(shell docker volume ls -qf "name=mariadb_data") || true
	docker volume rm $(shell docker volume ls -qf "name=monitor_data") || true

re: fclean all

.PHONY: all up down stop fclean re
