NAME = Inception
MYDATA_DIR = /home/agrimald/data
DB_DIR = $(MYDATA_DIR)/db_vol
WP_DIR = $(MYDATA_DIR)/wordpress_data
COMPOSE = docker compose -f src/docker-compose.yml

all: build up
	# Ejecuta build y luego up (levanta el entorno)

build:
	@mkdir -p $(DB_DIR)
	@mkdir -p $(WP_DIR)
	@$(COMPOSE) build
	# Construye las imágenes Docker

up:
	@$(COMPOSE) up -d
	# Levanta los contenedores en segundo plano

down:
	@$(COMPOSE) down
	# Detiene y elimina los contenedores (sin borrar volúmenes ni imágenes)

stop:
	@echo "Stopping containers"
	@cd src && docker compose stop

start:
	@echo "Starting containers"
	@cd src && docker compose start

clean: down
	@echo "🧹 Limpiando volúmenes y redes del proyecto..."
	@rm -rf $(DB_DIR)
	@rm -rf $(WP_DIR)
	@docker volume rm $(shell docker volume ls -q --filter name=db_vol --filter name=wordpress_data) 2>/dev/null || true
	@docker network rm $$(docker network ls -q) 2>/dev/null || true
	@docker system prune -af
	# Limpia volúmenes de tu proyecto y recursos innecesarios

re: clean all
	# Reinicia completamente el entorno Docker desde cero

.PHONY: all build stop start down clean re

