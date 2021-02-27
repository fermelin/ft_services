FROM	alpine:3.12.3

RUN 	apk update && apk upgrade

RUN		apk add openrc nginx supervisor php7 php7-fpm php7-mysqli php7-zlib \
		php7-curl php7-mbstring php7-json php7-session
		
RUN		mkdir www

RUN 	wget https://wordpress.org/latest.zip && unzip latest.zip && \
		mv wordpress /www/ && rm latest.zip

COPY 	./srcs/nginx.conf /etc/nginx/conf.d/default.conf
COPY 	./srcs/supervisord.conf /etc/supervisord.conf
COPY	./srcs/wp-config.php /www/

RUN		mkdir -p /run/nginx && chmod 744 /run/nginx

EXPOSE	5050

ENTRYPOINT /usr/bin/supervisord -c /etc/supervisord.conf


#edition needed
