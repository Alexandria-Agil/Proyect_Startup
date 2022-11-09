#!/bin/sh
sudo su
yum update -y
yum search docker
yum info docker
yum install docker -y
usermod -a -G docker ec2-user
id ec2-user
newgrp docker
systemctl enable docker.service
systemctl start docker.service
docker run -dit -p 8000:8000 rafaruizc/proyect_startup_fastapi
amazon-linux-extras install epel -y
yum install nginx -y
echo -e "upstream backend {\n    server server1:8000;\n}" > /etc/nginx/conf.d/backend_upstream.conf
echo -e "location /app1/ {\n  proxy_pass http://backend/;\n}" > /etc/nginx/default.d/backend_proxy.conf
systemctl enable nginx
systemctl restart nginx
