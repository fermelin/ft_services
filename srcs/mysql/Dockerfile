
FROM alpine:3.12

WORKDIR	/project

RUN		apk update && apk add 	nginx \
								mariadb \
								mariadb-client
								# mandoc man-pages vim

COPY	./script.sh /project/script.sh
COPY	./init_database.sql /project/init_database.sql
RUN		mysql && mysql < init_database.sql

RUN		/usr/bin/mysql_install_db --user=mysql --datadir="/var/lib/mysql"
# RUN		/usr/bin/mysqld_safe --datadir="/var/lib/mysql"
EXPOSE 3306

ENTRYPOINT ["/bin/sh", "/project/script.sh"]