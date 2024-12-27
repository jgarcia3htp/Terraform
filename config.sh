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
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/monitoring.yaml
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/Dockerfile_nginx
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/deploy.sh
curl -O https://raw.githubusercontent.com/nisanchezva/practicaGrupal/main/nginx.conf

#ejecutables (pendientes)
sudo sh /workdir/deploy.sh
#sudo su root
sudo minikube start --force