FROM	alpine:3.12.3

RUN     apk update && apk upgrade && apk add openrc

RUN     apk add grafana --repository=http://dl-3.alpinelinux.org/alpine/edge/community/

COPY    srcs/start.sh /

COPY    srcs/grafana.ini /usr/share/grafana/conf/custom.ini
COPY    srcs/datasources.yaml /usr/share/grafana/conf/provisioning/datasources/influxdb.yaml
COPY    srcs/dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/influxdb.yaml

RUN     mkdir -p /var/lib/grafana_dashboards/
COPY    srcs/dashboard.json /var/lib/grafana_dashboards/

EXPOSE  3000

ENTRYPOINT sh start.sh

#edition needed
