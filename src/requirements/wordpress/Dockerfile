FROM debian:11

# Install dependencies
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y vim curl wget php7.4 php7.4-fpm php7.4-mysql mariadb-client

# Download WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
&& chmod +x /usr/local/bin/wp

# Configure PHP-FPM
RUN mkdir -p /run/php \
    && sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# Create web directory
RUN mkdir -p /var/www/html

# Download and Install WordPress in Spanish
RUN wget https://es.wordpress.org/latest-es_ES.tar.gz -O /tmp/latest-es_ES.tar.gz \
    && tar -xvzf /tmp/latest-es_ES.tar.gz --strip-components=1 -C /var/www/html \
    && rm /tmp/latest-es_ES.tar.gz

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html/ \
	&& chmod -R 755 /var/www/html/

# Set working directory
WORKDIR /var/www/html/

# Copy WordPress setup script
COPY /tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

# Expose port for PHP-FPM
EXPOSE 9000
	
ENTRYPOINT ["/tmp/entrypoint.sh"]
