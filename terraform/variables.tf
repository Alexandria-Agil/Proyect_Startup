variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "shared_credentials_file" {
  default = "/root/.aws/credentials"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "public_subnet_cidr2" {
  default = "10.0.3.0/24"
}

variable "ami_dock" {
  default = "ami-09d3b3274b6c5d4aa"
}

variable "ami_lb"{
  default = "ami-01cc34ab2709337aa"
}

variable "key_path" {
  default = "/root/.ssh/id_rsa.pub"
}

### Output  ###
/*
output "nginx_dns_name" {
  value = aws_instance.nginx.public_dns
}
*/

output "Worker-node1_Private_IP" {
  value = aws_instance.server1.private_ip
}

output "elb-dns-name" {
  value = aws_lb.application-lb.dns_name
}
