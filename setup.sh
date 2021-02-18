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

minikube ip > /dev/null
if [ $? -ne 0 ]
then
	minikube start --driver=virtualbox
fi
minikube addons enable metallb
minikube dashboard &
eval $(minikube docker-env) && sleep 4

kubectl apply -f ./srcs/configmap.yaml

docker build -t nginx_image ./srcs/nginx
kubectl apply -f ./srcs/nginx/srcs/nginx.yaml

docker build -t mysql_image ./srcs/mysql
kubectl apply -f ./srcs/mysql/srcs/mysql.yaml