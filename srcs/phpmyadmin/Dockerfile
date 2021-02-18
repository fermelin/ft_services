FROM	alpine:3.12

RUN		apk update && apk upgrade
RUN 	apk add openrc nginx supervisor php7-fpm phpmyadmin

RUN 	mkdir -p /run/nginx && chown nginx:nginx /run/nginx
RUN		mkdir -p /var/tmp/phpmyadmin && chown nginx:nginx /var/tmp/phpmyadmin && chmod 777 /var/tmp/phpmyadmin

RUN		mkdir -p /www/phpmyadmin

COPY	./srcs/nginx.conf /etc/nginx/conf.d/default.conf
COPY	./srcs/config.inc.php /etc/phpmyadmin/
COPY	./srcs/supervisord.conf /etc/supervisord.conf

RUN		cp -r /usr/share/webapps/phpmyadmin/* /var/www/localhost/htdocs
RUN 	chown -R nginx:nginx /var/www/localhost/htdocs

EXPOSE	5000

ENTRYPOINT /usr/bin/supervisord -c /etc/supervisord.conf

#edition needed