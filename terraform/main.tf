provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.37.0"
        }
    }
    backend "s3" {
        bucket = "pdfapp-bucket-terraform"
        key    = "terra-state"
        region = "us-west-2"
        profile = "default"
    }
}

#Create a private key which can be used to login to the webserver
resource "tls_private_key" "Web-Key" {
    algorithm = "RSA"
}

#Save public key attributes from the generated key
resource "aws_key_pair" "default" {
    key_name = "Web-key"
    public_key = tls_private_key.Web-Key.public_key_openssh
}

#Save the key to your local system
resource "local_file" "Web-Key" {
    content = tls_private_key.Web-Key.private_key_pem
    filename = "Web-Key.pem"
}