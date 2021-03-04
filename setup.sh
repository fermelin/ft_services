#!/bin/bash

function echo_blue
{
	echo -e "\033[1;34;47m		$1		\033[0m"
}

function echo_red
{
	echo -e "\033[1;31;47m		$1		\033[0m"
}

function error
{
	echo_red "--$1 FAILED--"
	minikube delete
	exit 1
}

function build_image 
{
	echo_blue "--BUILDING $2 IMAGE--"

	attempts=0
	exit_status=0
	until [ $attempts -eq 3 ]
	do
		$1
		exit_status=$?
		if [ $exit_status -eq 0 ]
		then
			break
		fi
		((attempts=attempts+1))
	done

	if [ $exit_status -ne 0 ]
	then
		error $2
	fi
}

minikube start --driver=virtualbox

minikube dashboard &

minikube addons enable metallb
minikube addons enable metrics-server

kubectl apply -f ./srcs/configmap.yaml

kubectl create secret generic -n metallb-system memberlist \
    --from-literal=secretkey="$(openssl rand -base64 128)"

export MINIKUBE_IP=$(minikube ip)

eval $(minikube docker-env) && sleep 3

build_image "docker build -t nginx_image ./srcs/nginx" "NGINX"
kubectl apply -f ./srcs/k8s_deployments/nginx_deployment.yaml
kubectl apply -f ./srcs/k8s_services/nginx_service.yaml


build_image "docker build -t mysql_image ./srcs/mysql" "MYSQL"
kubectl apply -f ./srcs/k8s_volumes/mysql_volume.yaml
kubectl apply -f ./srcs/k8s_deployments/mysql_deployment.yaml
kubectl apply -f ./srcs/k8s_services/mysql_service.yaml


build_image "docker build -t ftps_image ./srcs/ftps" "FTPS"
kubectl apply -f ./srcs/k8s_volumes/ftps_volume.yaml
kubectl apply -f ./srcs/k8s_deployments/ftps_deployment.yaml
kubectl apply -f ./srcs/k8s_services/ftps_service.yaml


build_image "docker build -t phpmyadmin_image ./srcs/phpmyadmin" "PHPMYADMIN"
kubectl apply -f ./srcs/k8s_deployments/phpmyadmin_deployment.yaml
kubectl apply -f ./srcs/k8s_services/phpmyadmin_service.yaml


build_image "docker build -t wordpress_image ./srcs/wordpress" "WORDPRESS"
kubectl apply -f ./srcs/k8s_deployments/wordpress_deployment.yaml
kubectl apply -f ./srcs/k8s_services/wordpress_service.yaml


build_image "docker build -t influxdb_image ./srcs/influxdb" "INFLUXDB"
kubectl apply -f ./srcs/k8s_volumes/influxdb_volume.yaml
kubectl apply -f ./srcs/k8s_deployments/influxdb_deployment.yaml
kubectl apply -f ./srcs/k8s_services/influxdb_service.yaml


build_image "docker build -t telegraf_image --build-arg MINIKUBE_IP=${MINIKUBE_IP} ./srcs/telegraf" "TELEGRAF"
kubectl apply -f ./srcs/k8s_telegraf_daemon/


build_image "docker build -t grafana_image ./srcs/grafana" "GRAFANA"
kubectl apply -f ./srcs/k8s_deployments/grafana_deployment.yaml
kubectl apply -f ./srcs/k8s_services/grafana_service.yaml
