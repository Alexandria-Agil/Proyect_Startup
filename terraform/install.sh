#!/bin/sh
sudo yum update -y
sudo yum search docker
sudo yum info docker
sudo yum install docker -y
sudo usermod -a -G docker ec2-user
id ec2-user
newgrp docker
sudo systemctl enable docker.service
sudo systemctl start docker.service
docker run -dit -p 80:8000 rafaruizc/proyect_startup_fastapi