FROM	alpine:3.12.3

WORKDIR	/project

RUN		apk update && apk upgrade \
		&& apk add nginx openssl openssh

RUN		adduser -D -g 'www' www
RUN		mkdir /www && chown -R www:www /www
RUN		chown -R www:www /var/lib/nginx
RUN		mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

RUN		ssh-keygen -A
RUN		mkdir -p /run/nginx /run/sshd
RUN		sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN		echo "root:password" | chpasswd
RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt \
		-subj "/C=RU/ST=Russia/L=Moscow/O=21_School/OU=4th_Wave/CN=fermelin"

COPY	./srcs/nginx.conf /etc/nginx/nginx.conf
COPY	./srcs/index.html /www/index.html
COPY	./srcs/wrapper_script.sh /project/wrapper_script.sh

EXPOSE	22 80 443

ENTRYPOINT	["/bin/sh", "/project/wrapper_script.sh"]
