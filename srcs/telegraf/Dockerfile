FROM	alpine:3.12.3

ARG     MINIKUBE_IP

RUN		apk update && apk upgrade \
		&& apk add telegraf --repository=http://dl-3.alpinelinux.org/alpine/edge/community/

COPY	./srcs/telegraf.conf /etc/telegraf/telegraf.conf

RUN     mkdir -p /etc/telegraf/
RUN		sed -i "s/MINIKUBE_IP/$MINIKUBE_IP/g" /etc/telegraf/telegraf.conf

VOLUME  /var/run/docker.sock

ENTRYPOINT	["telegraf", "--config", "/etc/telegraf/telegraf.conf"]
