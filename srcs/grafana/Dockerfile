FROM	alpine:3.12.3

RUN     apk update && apk upgrade \
		&& apk add grafana --repository=http://dl-3.alpinelinux.org/alpine/edge/community/

RUN     mkdir -p /var/lib/grafana_dashboards/

COPY    srcs/grafana.ini /usr/share/grafana/conf/custom.ini
COPY    srcs/datasources.yaml /usr/share/grafana/conf/provisioning/datasources/influxdb.yaml
COPY    srcs/dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/influxdb.yaml
COPY    srcs/dashboard.json /var/lib/grafana_dashboards/

EXPOSE  3000

ENTRYPOINT	["/usr/sbin/grafana-server", "--homepath=/usr/share/grafana"]
