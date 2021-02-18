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

FROM	alpine:3.12

WORKDIR	/project

RUN		apk update && apk add	nginx \
								openssl \
								openssh \
								mandoc man-pages vim
# ADD		https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz phpmyadmin.tar.gz
# RUN		tar xzf phpmyadmin.tar.gz && mv phpMyAdmin-5.0.2-all-languages /var/www/html/phpmyadmin
# RUN		rm phpmyadmin.tar.gz

# create dir for nginx
# RUN		mkdir /var/www/localhost/ 
RUN		adduser -D -g 'www' www

RUN		mkdir /www
RUN		chown -R www:www /var/lib/nginx

RUN		mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
COPY	./srcs/nginx.conf /etc/nginx/nginx.conf
COPY	./srcs/index.html /www/index.html
# COPY	./srcs/supervisord.conf /etc/supervisord.conf
# COPY	./srcs/start_services.sh /project/start_services.sh
COPY	./srcs/wrapper_script.sh /project/wrapper_script.sh
# COPY	./srcs/srcs/default /etc/nginx/nginx.conf
# COPY	./srcs/srcs/autoindex.sh /project/

RUN		chown -R www:www /www
# RUN		mv /usr/share/wordpress /var/www/html

# COPY	./srcs/srcs/wp-config.php /var/www/html/wordpress
# COPY	./srcs/srcs/config.inc.php /var/www/html/phpmyadmin

RUN ssh-keygen -A

# RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN echo "root:password" | chpasswd

RUN adduser -D fermelin ; echo "fermelin:password" | chpasswd

# RUN		rm /var/www/html/index*

RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt \
		-subj "/C=RU/ST=Russia/L=Moscow/O=21 School/OU=4th Wave/CN=Vadim Borisov"

# RUN		chown -R www-data /var/www/html

# RUN 	service mysql start && mysql < db_init.sql
RUN		mkdir -p /run/nginx

EXPOSE 22 80 443

# ENTRYPOINT ["bash", "start_services.sh"]
# ENTRYPOINT	nginx
# ENTRYPOINT	["/bin/sh", "/project/start_services.sh"]
ENTRYPOINT	["/bin/sh", "/project/wrapper_script.sh"]