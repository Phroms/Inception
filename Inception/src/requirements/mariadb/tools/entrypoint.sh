#!/bin/bash
set -e

envsubst < /docker-entrypoint-initdb.d/init-db.template > /docker-entrypoint-initdb.d/init-db.sql

exec mysqld_safe --init-file=/docker-entrypoint-initdb.d/init-db.sql
