FROM	alpine:3.12.3

WORKDIR	/project

RUN		apk update && apk upgrade \
		&& apk add nginx php7-fpm phpmyadmin

RUN 	mkdir -p /run/nginx && chown nginx:nginx /run/nginx
RUN		mkdir -p /var/tmp/phpmyadmin && chown nginx:nginx /var/tmp/phpmyadmin && chmod 777 /var/tmp/phpmyadmin

RUN		mkdir -p /www/phpmyadmin

COPY	./srcs/nginx.conf /etc/nginx/conf.d/default.conf
COPY	./srcs/config.inc.php /etc/phpmyadmin/
COPY	./srcs/wrapper_script.sh /project/wrapper_script.sh

RUN		cp -r /usr/share/webapps/phpmyadmin/* /var/www/localhost/htdocs
RUN 	chown -R nginx:nginx /var/www/localhost/htdocs

EXPOSE	5000

ENTRYPOINT	["/bin/sh", "/project/wrapper_script.sh"]

#edition needed