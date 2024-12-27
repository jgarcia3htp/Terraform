#! /bin/bash

#actualizacion de paquetes
sudo apt-get update

#docker
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

#directorio trabajo
sudo mkdir /workdir
cd /workdir/

#kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

#granafa y proxy inverso
    #grafana
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/monitoring.yaml
    #proxy inverso
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/Dockerfile_nginx
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/deploy.sh
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/nginx.conf
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/dashboard.json

#aplicacion .war
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/tomcat-deploy.yaml
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/tomcat-hpa.yaml
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/tomcat-pvc.yaml
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/tomcat-svc.yaml

#ejecutables iniciales
sudo sh /workdir/deploy.sh
sudo minikube start --force
sudo kubectl config use-context minikube

#ejecutables
sudo kubectl create namespace monitoring
sudo kubectl create configmap grafana-dashboard -n monitoring --from-file=./dashboard.json
sudo kubectl apply -f monitoring.yaml
sudo kubectl apply -f tomcat-deploy.yaml
sudo kubectl apply -f tomcat-svc.yaml
sudo kubectl apply -f tomcat-pvc.yaml
sudo kubectl apply -f tomcat-hpa.yaml