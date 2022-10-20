minikube start
kubectl delete ns airflow-cluster
kubectl delete daemonsets,replicasets,services,deployments,pods,rc,ingress --all --all-namespaces
cd airflow
kubectl create ns airflow-cluster
helm install airflow-cluster airflow-stable/airflow --namespace airflow-cluster --version "8.X.X" --values ./custom-values.yaml