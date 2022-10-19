# Proyect_Startup
Alexandria Library is an app where you read pdfs from anywhere and you can upload your pdfs too, meaning that your creations could be readen by someone else and he can follow you because you upload interesting things.

You can search PDFs using some criterias like name, category, publisher, etc. This application offers many facilities and options that allow you to enjoy your lecture
## Run instructions
### Prerrequisites
* minikube
* kubectl
### Commands on Terminal (Linux)
* start a cluster with ```minikube start```
* go to the kubernet configuration folder with ```cd kubernet_conf```
* run this command to create the pods and services that the cluster needs
```kubectl apply -f api-api-env-configmap.yaml,api-deployment.yaml,api-service.yaml,api-volume-persistentvolumeclaim.yaml,appnet-networkpolicy.yaml,db-database-env-configmap.yaml,db-deployment.yaml,db-service.yaml,nuxt-claim0-persistentvolumeclaim.yaml,nuxt-claim1-persistentvolumeclaim.yaml,nuxt-deployment.yaml,nuxt-service.yaml,nuxt2-claim0-persistentvolumeclaim.yaml,nuxt2-claim1-persistentvolumeclaim.yaml,nuxt2-deployment.yaml,nuxt2-service.yaml,nginx-deployment.yaml,nginx-service.yaml,airflow-cli-claim0-persistentvolumeclaim.yaml,airflow-cli-claim1-persistentvolumeclaim.yaml,airflow-cli-claim2-persistentvolumeclaim.yaml,airflow-cli-deployment.yaml,airflow-init-claim0-persistentvolumeclaim.yaml,airflow-init-claim1-persistentvolumeclaim.yaml,airflow-init-claim2-persistentvolumeclaim.yaml,airflow-init-claim3-persistentvolumeclaim.yaml,airflow-init-deployment.yaml,airflow-scheduler-claim0-persistentvolumeclaim.yaml,airflow-scheduler-claim1-persistentvolumeclaim.yaml,airflow-scheduler-claim2-persistentvolumeclaim.yaml,airflow-scheduler-deployment.yaml,airflow-triggerer-claim0-persistentvolumeclaim.yaml,airflow-triggerer-claim1-persistentvolumeclaim.yaml,airflow-triggerer-claim2-persistentvolumeclaim.yaml,airflow-triggerer-deployment.yaml,airflow-webserver-claim0-persistentvolumeclaim.yaml,airflow-webserver-claim1-persistentvolumeclaim.yaml,airflow-webserver-claim2-persistentvolumeclaim.yaml,airflow-webserver-deployment.yaml,airflow-webserver-service.yaml,postgres-db-volume-persistentvolumeclaim.yaml,postgres-deployment.yaml```
* check the state of the pods with ```kubectl get pods``` and wait until every pod is in state "running"
* run the application with ```kubectl port-forward service/nuxt 3001:3001 & kubectl port-forward service/nuxt2 3002:3002 & kubectl port-forward service/api 5000:5000 & kubectl port-forward service/nginx 9000:9000 & kubectl port-forward service/airflow-webserver 8080:8080```