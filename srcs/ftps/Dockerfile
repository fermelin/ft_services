FROM	alpine:3.12.3

WORKDIR	/project

RUN 	apk update && apk upgrade \
		&& apk add vsftpd openssl

RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt \
		-subj "/C=RU/ST=Russia/L=Moscow/O=21_School/OU=4th_Wave/CN=fermelin"

RUN     mkdir -p /var/lib/ftp \
		&& chmod 757 -R /var/lib/ftp

RUN     adduser -D -h /var/lib/ftp fermelin \
		&& echo "fermelin:password" | chpasswd

COPY    /srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE  21 20021

VOLUME  /var/lib/ftp

ENTRYPOINT	["vsftpd", "/etc/vsftpd/vsftpd.conf"]
