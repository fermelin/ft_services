FROM	alpine:3.12

RUN 	apk update && apk upgrade
RUN	apk add vsftpd openssl

RUN     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -subj '/C=RU/ST=Moscow/L=Moscow/O=42/OU=21/CN=fermelin' \
        -keyout /etc/ssl/private/vsftpd.key \
        -out /etc/ssl/certs/vsftpd.crt

RUN     mkdir -p /var/lib/ftp

RUN     adduser -D -h /var/lib/ftp fermelin; echo "fermelin:password" | chpasswd

COPY    /srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY    /srcs/start.sh .

RUN     chmod 711 start.sh

EXPOSE  21 20021
VOLUME  /var/lib/ftp
ENTRYPOINT sh start.sh

#edition needed