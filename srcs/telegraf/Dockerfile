FROM	alpine:3.12

ARG     MINIKUBE_IP

RUN	apk update && apk upgrade

RUN     apk add telegraf --repository=http://dl-3.alpinelinux.org/alpine/edge/testing/

RUN     mkdir -p /etc/telegraf/

COPY    ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

RUN     sed -i "s/MINIKUBE_IP/$MINIKUBE_IP/g" /etc/telegraf/telegraf.conf

VOLUME  /var/run/docker.sock

ENTRYPOINT telegraf --config /etc/telegraf/telegraf.conf

#edition needed
