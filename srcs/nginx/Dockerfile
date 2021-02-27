# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fermelin <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/21 16:14:18 by fermelin          #+#    #+#              #
#    Updated: 2020/09/30 17:58:32 by fermelin         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:3.12.3

WORKDIR	/project

RUN		apk update && apk upgrade && apk add	openrc \
								nginx \
								openssl \
								openssh \
								mandoc man-pages vim

RUN		adduser -D -g 'www' www

RUN		mkdir /www
RUN		chown -R www:www /var/lib/nginx

RUN		mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
COPY	./srcs/nginx.conf /etc/nginx/nginx.conf
COPY	./srcs/index.html /www/index.html

COPY	./srcs/wrapper_script.sh /project/wrapper_script.sh


RUN		chown -R www:www /www


RUN ssh-keygen -A

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN echo "root:password" | chpasswd

RUN adduser -D fermelin ; echo "fermelin:password" | chpasswd


RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt \
		-subj "/C=RU/ST=Russia/L=Moscow/O=21 School/OU=4th Wave/CN=fermelin"

RUN		mkdir -p /run/nginx /run/sshd

EXPOSE 22 80 443

ENTRYPOINT	["/bin/sh", "/project/wrapper_script.sh"]