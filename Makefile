NAME = Inception
MYDATA_DIR = /home/agrimald/data
DB_DIR = $(MYDATA_DIR)/db_vol
WP_DIR = $(MYDATA_DIR)/wordpress_data
all: build up #Al ejecutar 'make'(sin argumentos), se ejecutan los objetivos 'build' y 'up' "es igual = make build y make up"

build:  # Construye los contenedore definidos en 'docker-compose.yml'
	@mkdir -p $(DB_DIR)
	@mkdir -p $(WP_DIR)
	@docker compose -f src/docker-compose.yml build
	# Lee los Dockerfiles y crea las imagenes

up:	# Levanta los contenedores en modo "detached" (-d), es decir, en segundo plano
	@docker compose -f src/docker-compose.yml up -d
	# Inicia los servicios sin bloquear la terminal.
	# Si no existian contenedores antes, tambien los construye automaticamente

down:	# Detiene y elimina los contenedores definidos en 'docker-compose.yml'
	@docker compose -f src/docker-compose.yml down
	# No borra las imagenes ni los volumenes
stop:
	@echo "Stopping containers"
	@cd src && docker compose stop
start:
	@echo "Starting containers"
	@cd src && docker compose start
clean: down
	@docker system prune -af
	@docker volume rm $(shell docker volume ls -q)
	# Primero ejecuta 'make down' (detiene los contenedores)
	# Luego ejecuta: 'docker system prune -af'
	# Borra imagenes, conteneores y redes no utilizadas.
	# '-a' borra todas las imagenes no usadas.
	# '-f' fuerza la eliminacion sin pedir confirmacion.
	# Finalmente, borra todos los volumenes de Docker con: 'docker volume rm$(shell docker volume ls -q)'
	# 'docker volume ls -q' lista todos los volumenes
	# 'docker volume rm' los elimina.

re: clean all
	# Ejecuta 'clean' (borra todo) y luego all (recontruye y levanta los contenedores).
	# Basicamente, reinicia todo el entorno Docker.

.PHONY: all build stop start down clean fclean re
