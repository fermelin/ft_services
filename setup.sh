#!/bin/bash

# minikube start --driver=virtualbox

# minikube dashboard &

# minikube addons enable metallb
# minikube addons enable metrics-server

# kubectl apply -f ./srcs/configmap.yaml

# kubectl create secret generic -n metallb-system memberlist \
#     --from-literal=secretkey="$(openssl rand -base64 128)"

# export MINIKUBE_IP=$(minikube ip)

# eval $(minikube docker-env) && sleep 3

# attempts=0
# until [ $? -eq 1  && $(attempts) -le 3]
# do
# 	docker build -t nginx_image ./srcs/nginx
# 	((attempts))++
# done
# attempts=0
# kubectl apply -f ./srcs/nginx/nginx.yaml



# minikube ip > /dev/null
# if [ $? -ne 0 ]
# then
# 	minikube start --driver=virtualbox
# fi
# minikube addons enable metallb
# minikube dashboard &
# eval $(minikube docker-env) && sleep 4

# kubectl apply -f ./srcs/configmap.yaml

# docker build -t nginx_image ./srcs/nginx
# kubectl apply -f ./srcs/nginx/srcs/nginx.yaml

# docker build -t mysql_image ./srcs/mysql
# kubectl apply -f ./srcs/mysql/srcs/mysql.yaml


#______________________________________________________________________________________

minikube start --vm-driver=virtualbox

minikube dashboard &

minikube addons enable metallb
minikube addons enable metrics-server

kubectl apply -f ./srcs/configmap.yaml

kubectl create secret generic -n metallb-system memberlist \
    --from-literal=secretkey="$(openssl rand -base64 128)"

export MINIKUBE_IP=$(minikube ip)

eval $(minikube docker-env) && sleep 3

printf "\nNGINX..."
docker build -t nginx ./srcs/nginx
echo "Ok"
kubectl apply -f ./srcs/k8s_deployments/nginx-deploy.yaml
kubectl apply -f ./srcs/k8s_services/nginx-service.yaml

printf "\nMYSQL..."
docker build -t mysql ./srcs/mysql
echo "Ok"
kubectl apply -f ./srcs/k8s_volumes/mysql-volume.yaml
kubectl apply -f ./srcs/k8s_deployments/mysql-deploy.yaml
kubectl apply -f ./srcs/k8s_services/mysql-service.yaml

printf "\nFTPS..."
docker build -t ftps ./srcs/ftps
echo "Ok"
kubectl apply -f ./srcs/k8s_volumes/ftps-volume.yaml
kubectl apply -f ./srcs/k8s_deployments/ftps-deploy.yaml
kubectl apply -f ./srcs/k8s_services/ftps-service.yaml

printf "\nPHPMYADMIN..."
docker build -t phpmyadmin ./srcs/phpmyadmin
echo "Ok"
kubectl apply -f ./srcs/k8s_deployments/phpmyadmin-deploy.yaml
kubectl apply -f ./srcs/k8s_services/phpmyadmin-service.yaml

printf "\nWORDPRESS..."
docker build -t wordpress ./srcs/wordpress
echo "Ok"
kubectl apply -f ./srcs/k8s_deployments/wordpress-deploy.yaml
kubectl apply -f ./srcs/k8s_services/wordpress-service.yaml

printf "\nINFLUXDB..."
docker build -t influxdb ./srcs/influxdb
echo "Ok"
kubectl apply -f ./srcs/k8s_volumes/influxdb-volume.yaml
kubectl apply -f ./srcs/k8s_deployments/influxdb-deploy.yaml
kubectl apply -f ./srcs/k8s_services/influxdb-service.yaml

printf "\nTELEGRAF..."
docker build --build-arg MINIKUBE_IP=${MINIKUBE_IP} -t telegraf ./srcs/telegraf
echo "Ok"
kubectl apply -f ./srcs/k8s_telegraf_daemon/

printf "\nGRAFANA..."
docker build -t grafana ./srcs/grafana
echo "Ok"
kubectl apply -f ./srcs/k8s_deployments/grafana-deploy.yaml
kubectl apply -f ./srcs/k8s_services/grafana-service.yaml
