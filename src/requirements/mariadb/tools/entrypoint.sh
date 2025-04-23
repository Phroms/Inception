#!/bin/bash
set -e

# Solo ejecutar init si la base de datos aún no fue inicializada
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "⏳ Inicializando base de datos..."
    envsubst < /docker-entrypoint-initdb.d/init-db.template > /docker-entrypoint-initdb.d/init-db.sql
    mysqld --user=mysql --bootstrap < /docker-entrypoint-initdb.d/init-db.sql
else
    echo "✅ Base de datos ya inicializada. Saltando creación."
fi

exec mysqld_safe
