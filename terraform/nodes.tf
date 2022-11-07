resource "aws_instance" "server1" {
  ami = var.ami_dock
  instance_type = var.instance_type
  key_name = aws_key_pair.default.id
  subnet_id = aws_subnet.public-subnet.id
  security_groups = ["${aws_security_group.instancesg.id}"]
  associate_public_ip_address = true
  provisioner "remote-exec" {
    connection {
        host = self.public_ip
        type = "ssh"
        user = "ec2-user"
        private_key = tls_private_key.Web-Key.private_key_pem
        timeout = "1m"
        agent = "false"
      }
    inline = [
      "sudo sed -i -e '$a\\' -e '${aws_instance.server1.private_ip} server1' /etc/hosts"
    ]
  } 
  user_data = file("install.sh")

  tags = {
    Name = "worker-node1"
  }
}