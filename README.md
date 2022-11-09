# Proyect_Startup
Alexandria Library is an app where you read pdfs from anywhere and you can upload your pdfs too, meaning that your creations could be readen by someone else and he can follow you because you upload interesting things.

You can search PDFs using some criterias like name, category, publisher, etc. This application offers many facilities and options that allow you to enjoy your lecture
## Run instructions
### Prerrequisites
* minikube
* kubectl
* helm
### Commands on Terminal (Linux)
* start a cluster with ```minikube start```
* go to the airflow folder with ```cd airflow```
* get the airflow repo with ```helm repo add airflow-stable https://airflow-helm.github.io/charts```
* update the repo with ```helm repo update```
* execute this command ```kubectl create ns airflow-cluster```
* then run this command ```helm install airflow-cluster airflow-stable/airflow --namespace airflow-cluster --version "8.X.X" --values ./custom-values.yaml```
* Go back to the main folder ```cd ..```
* go to the kubernet configuration folder with ```cd kubernet_conf```
* run this command to create the pods and services that the cluster needs
```kubectl apply -f api-api-env-configmap.yaml,api-deployment.yaml,api-service.yaml,api-volume-persistentvolumeclaim.yaml,appnet-networkpolicy.yaml,db-database-env-configmap.yaml,db-deployment.yaml,db-service.yaml,nuxt-claim0-persistentvolumeclaim.yaml,nuxt-claim1-persistentvolumeclaim.yaml,nuxt-deployment.yaml,nuxt-service.yaml,nuxt2-claim0-persistentvolumeclaim.yaml,nuxt2-claim1-persistentvolumeclaim.yaml,nuxt2-deployment.yaml,nuxt2-service.yaml,nginx-deployment.yaml,nginx-service.yaml,fastapi-claim0-persistentvolumeclaim.yaml,fastapi-deployment.yaml,fastapi-service.yaml```
* check the state of the pods with ```kubectl get pods -A``` and wait until every pod is in state "running"
* run the application with ```kubectl port-forward service/nuxt 3001:3001 & kubectl port-forward service/nuxt2 3002:3002 & kubectl port-forward service/api 5000:5000 & kubectl port-forward service/nginx 9000:9000 & kubectl port-forward svc/airflow-cluster-web 8080:8080 --namespace airflow-cluster```