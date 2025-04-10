# Usamos la imagen de NGINX basada en Debian, sin olvidar que no se puede usar el tag 'latest'
FROM debian:bullseye

# Instalar NGINX y OpenSSL
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y nginx openssl && \
	rm -rf /var/lib/apt/lists/*

# Copiar la configuracion de NGINX
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Crear el directorio para los certificados SSL
RUN mkdir -p /etc/ssl/certs /etc/ssl/private

RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/private/ssl-cert-snakeoil.key -out /etc/ssl/certs/ssl-cert-snakeoil.pem -days 365 -nodes \
    -subj "/C=ES/ST=Barcelona/L=Barcelona/O=42/OU=42/CN=localhost"

# Exponer el puerto 443 para el trafico HTTPS
EXPOSE 443

# Configurar el entrypoint para ejecutar NGINX
CMD ["nginx", "-g", "daemon off;"]
