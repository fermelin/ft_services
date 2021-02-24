#!/bin/bash

# minikube start --driver=virtualbox
# minikube addons enable metallb
# eval $(minikube docker-env)

# kubectl apply -f ./srcs/configmap.yaml
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
kubectl apply -f ./srcs/yaml-deploy/nginx-deploy.yaml
kubectl apply -f ./srcs/yaml-service/nginx-service.yaml

printf "\nMYSQL..."
docker build -t mysql ./srcs/mysql
echo "Ok"
kubectl apply -f ./srcs/yaml-volume/mysql-volume.yaml
kubectl apply -f ./srcs/yaml-deploy/mysql-deploy.yaml
kubectl apply -f ./srcs/yaml-service/mysql-service.yaml

printf "\nFTPS..."
docker build -t ftps ./srcs/ftps
echo "Ok"
kubectl apply -f ./srcs/yaml-volume/ftps-volume.yaml
kubectl apply -f ./srcs/yaml-deploy/ftps-deploy.yaml
kubectl apply -f ./srcs/yaml-service/ftps-service.yaml

printf "\nPHPMYADMIN..."
docker build -t phpmyadmin ./srcs/phpmyadmin
echo "Ok"
kubectl apply -f ./srcs/yaml-deploy/phpmyadmin-deploy.yaml
kubectl apply -f ./srcs/yaml-service/phpmyadmin-service.yaml

printf "\nWORDPRESS..."
docker build -t wordpress ./srcs/wordpress
echo "Ok"
kubectl apply -f ./srcs/yaml-deploy/wordpress-deploy.yaml
kubectl apply -f ./srcs/yaml-service/wordpress-service.yaml

printf "\nINFLUXDB..."
docker build -t influxdb ./srcs/influxdb
echo "Ok"
kubectl apply -f ./srcs/yaml-volume/influxdb-volume.yaml
kubectl apply -f ./srcs/yaml-deploy/influxdb-deploy.yaml
kubectl apply -f ./srcs/yaml-service/influxdb-service.yaml

printf "\nTELEGRAF..."
docker build --build-arg MINIKUBE_IP=${MINIKUBE_IP} -t telegraf ./srcs/telegraf
echo "Ok"
kubectl apply -f ./srcs/yaml-daemon/

printf "\nGRAFANA..."
docker build -t grafana ./srcs/grafana
echo "Ok"
kubectl apply -f ./srcs/yaml-deploy/grafana-deploy.yaml
kubectl apply -f ./srcs/yaml-service/grafana-service.yaml