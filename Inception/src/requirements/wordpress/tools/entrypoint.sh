#!/bin/bash
set -e

until mysqladmin ping -h mariadb --silent; do
	echo "Esperando a que MariaDB este disponible..."
	sleep 2
done

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

exec php-fpm7.4 -F
