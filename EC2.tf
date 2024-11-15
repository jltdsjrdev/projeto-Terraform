# resource "aws_instance" "instancia" {
#   ami           = "ami-063d43db0594b521b"
#   instance_type = "t2.micro"

#   network_interface {
#     network_interface_id = aws_network_interface.foo.id
#     device_index         = 0
#   }

#   credit_specification {
#     cpu_credits = "freetier"
#   }
resource "aws_instance" "private-ec2-a" {
  ami             = "ami-063d43db0594b521b"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.privada-a.id
  security_groups = [aws_security_group.allow_http.id]

  tags = {
    Name = "private-ec2-a"
  }
}

resource "aws_instance" "private-ec2-b" {
  ami             = "ami-063d43db0594b521b"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.privada-b.id
  security_groups = [aws_security_group.allow_http.id]

  tags = {
    Name = "private-ec2-b"
  }
}

resource "aws_instance" "private-ec2-c" {
  ami             = "ami-063d43db0594b521b"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.privada-c.id
  security_groups = [aws_security_group.allow_http.id]

  tags = {
    Name = "private-ec2-c"
  }
}