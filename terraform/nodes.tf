resource "aws_instance" "server1" {
  ami = var.ami_dock
  instance_type = var.instance_type
  key_name = aws_key_pair.default.id
  subnet_id = aws_subnet.public-subnet.id
  security_groups = ["${aws_security_group.instancesg.id}"]
  associate_public_ip_address = true
  user_data = file("install.sh")

  tags = {
    Name = "worker-node1"
  }
}