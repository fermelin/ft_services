FROM	alpine:3.12.3

WORKDIR	/project

RUN 	apk update && apk upgrade

RUN		apk add openrc nginx php7 php7-fpm php7-mysqli php7-zlib \
		php7-curl php7-mbstring php7-json php7-session

RUN		mkdir /www

RUN 	wget https://wordpress.org/latest.zip && unzip latest.zip && \
		mv wordpress /www && rm latest.zip

COPY 	./srcs/nginx.conf /etc/nginx/conf.d/default.conf
COPY	./srcs/wp-config.php /www/wordpress
COPY	./srcs/wrapper_script.sh /project/wrapper_script.sh

RUN		mkdir -p /run/nginx && chmod 744 /run/nginx

EXPOSE	5050

ENTRYPOINT	["/bin/sh", "/project/wrapper_script.sh"]
