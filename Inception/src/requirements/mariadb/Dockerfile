FROM debian:bullseye

# Install al thing necesary from mariadb works
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y mariadb-server gettext && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /docker-entrypoint-initdb.d

RUN mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY tools/init-db.sql /docker-entrypoint-initdb.d/init-db.template

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306
ENTRYPOINT ["/entrypoint.sh"]
