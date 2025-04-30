#!/bin/bash

# Sustituir variables de entorno en el template y arrancar nginx
envsubst '${DOMAIN_NAME}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec nginx -g "daemon off;"
