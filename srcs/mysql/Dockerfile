FROM alpine:3.12.3

WORKDIR	/project

RUN		apk update && apk upgrade \
		&& apk add openrc mysql mysql-client

RUN		mkdir /run/mysqld && chown -R mysql /run/mysqld

COPY	./srcs/start_mysql.sh /project/start_mysql.sh
COPY	./srcs/init_database.sql /project/init_database.sql
COPY	./srcs/wordpress.sql /project/wordpress.sql
COPY	./srcs/my.cnf /etc/my.cnf

EXPOSE 3306

ENTRYPOINT ["/bin/sh", "/project/start_mysql.sh"]
