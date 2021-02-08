
FROM alpine:3.12

WORKDIR	/project

RUN		apk update && apk add openrc mysql mysql-client && \
		mkdir /run/mysqld && chown -R mysql /run/mysqld

COPY	./script.sh /project/script.sh
COPY	./init_database.sql /project/init_database.sql

RUN		mkdir -p /run/mysqld
RUN		touch /run/mysqld/mysqld.sock
RUN		mysql && mysql < init_database.sql

RUN		sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf

RUN		/usr/bin/mysql_install_db --user=mysql --datadir="/var/lib/mysql"
# RUN		/usr/bin/mysqld_safe --datadir="/var/lib/mysql"
EXPOSE 3306

ENTRYPOINT ["/bin/sh", "/project/script.sh"]