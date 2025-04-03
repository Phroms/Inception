FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y vim curl wget php7.4 php7.4-fpm php7.4-mysql mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp \
&& chmod +x /usr/local/bin/wp

RUN mkdir -p /run/php \
&& sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = 9000#g' /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://wordpress.org/wordpress-6.7.2.tar.gz -P /var/www/html && \
	cd /var/www/html && tar -xzf wordpress-6.7.2.tar.gz && rm wordpress-6.7.2.tar.gz

RUN chown -R www-data:www-data /var/www/html/ \
	&& chmod -R 755 /var/www/html/

WORKDIR /var/www/html/

COPY /tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/tmp/entrypoint.sh"]
