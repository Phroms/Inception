FROM debian:bullseye

# Instalar NGINX, OpenSSL y envsubst (parte de gettext)
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl gettext && \
    rm -rf /var/lib/apt/lists/*

# Crear directorios de certificados
RUN mkdir -p /etc/ssl/certs /etc/ssl/private && \
    openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/private/ssl-cert-snakeoil.key -out /etc/ssl/certs/ssl-cert-snakeoil.pem -days 365 -nodes \
    -subj "/C=ES/ST=Barcelona/L=Barcelona/O=42/OU=42/CN=localhost"

# Copiar archivos
COPY conf/nginx.conf /etc/nginx/nginx.conf.template
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
