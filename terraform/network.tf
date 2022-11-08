### Network Block ###
## Define our VPC
resource "aws_vpc" "pdfvpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "pdfvpc"
  }
}
## Define the public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.pdfvpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "lb_Public_Subnet"
  }
}


resource "aws_subnet" "public-subnet2" {
  vpc_id = aws_vpc.pdfvpc.id
  cidr_block = var.public_subnet_cidr2
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "lb_Public_Subnet2"
  }
}


## Define the internet gateway
resource "aws_internet_gateway" "lbgw" {
  vpc_id = aws_vpc.pdfvpc.id

  tags = {
    Name = "VPC_LB_IGW"
  }
}
## Define the route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.pdfvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lbgw.id
  }

  tags = {
    Name = "Public_Subnet_RT"
  }
}

## Assign the route table to the public Subnet
resource "aws_route_table_association" "public-rt" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}


resource "aws_route_table_association" "public-rt2" {
  subnet_id = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.public-rt.id
}


/*
data "aws_vpc" "default"{
    default = true
}

data "aws_subnet_ids" "subnet" {
    vpc_id = data. aws_vpc.default.id
}
*/
