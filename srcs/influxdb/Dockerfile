FROM	alpine:3.12.3

RUN		apk update && apk upgrade \
		&& apk add influxdb

COPY    ./srcs/influxdb.conf /etc/influxdb.conf

EXPOSE  8086

VOLUME  /var/lib/influxdb

ENTRYPOINT	["influxd"]
