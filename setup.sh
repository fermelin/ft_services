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

minikube start --driver=virtualbox
minikube addons enable metallb
eval $(minikube docker-env)

kubectl apply -f ./srcs/configmap.yaml

docker build -t nginx_image ./srcs/nginx
kubectl apply -f ./srcs/nginx/nginx.yaml