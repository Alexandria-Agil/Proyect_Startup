minikube start
kubectl delete ns airflow-cluster
kubectl delete daemonsets,replicasets,services,deployments,pods,rc,ingress --all --all-namespaces
cd kubernet_conf
kubectl apply -f api-api-env-configmap.yaml,api-deployment.yaml,api-service.yaml,api-volume-persistentvolumeclaim.yaml,appnet-networkpolicy.yaml,db-database-env-configmap.yaml,db-deployment.yaml,db-service.yaml,nuxt-claim0-persistentvolumeclaim.yaml,nuxt-claim1-persistentvolumeclaim.yaml,nuxt-deployment.yaml,nuxt-service.yaml,nuxt2-claim0-persistentvolumeclaim.yaml,nuxt2-claim1-persistentvolumeclaim.yaml,nuxt2-deployment.yaml,nuxt2-service.yaml,nginx-deployment.yaml,nginx-service.yaml