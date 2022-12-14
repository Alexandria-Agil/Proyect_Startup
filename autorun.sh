#!/bin/sh
minikube start 
kubectl delete ns airflow-cluster 
kubectl delete daemonsets,replicasets,services,deployments,pods,rc,ingress --all --all-namespaces 
cd airflow 
kubectl create ns airflow-cluster 
helm install airflow-cluster airflow-stable/airflow --namespace airflow-cluster --version "8.X.X" --values ./custom-values.yaml 
cd .. 
cd kubernet_conf 
kubectl apply -f api-api-env-configmap.yaml,api-deployment.yaml,api-service.yaml,api-volume-persistentvolumeclaim.yaml,appnet-networkpolicy.yaml,db-database-env-configmap.yaml,db-deployment.yaml,db-service.yaml,nuxt-claim0-persistentvolumeclaim.yaml,nuxt-claim1-persistentvolumeclaim.yaml,nuxt-deployment.yaml,nuxt-service.yaml,nuxt2-claim0-persistentvolumeclaim.yaml,nuxt2-claim1-persistentvolumeclaim.yaml,nuxt2-deployment.yaml,nuxt2-service.yaml,nginx-deployment.yaml,nginx-service.yaml,fastapi-claim0-persistentvolumeclaim.yaml,fastapi-deployment.yaml,fastapi-service.yaml 