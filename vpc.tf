resource "aws_vpc" "ada_vpc" {
  cidr_block = var.cidrvpc

  tags = {
    vpc = "ada"
    name = "terraform-ada"
  }
}  

resource "aws_subnet" "publica-a" {
  vpc_id = aws_vpc.ada_vpc.id
  cidr_block = var.cidrpublica-a
  availability_zone = "publica-a"
  tags = {
    name = "publica-a"
  }
  depends_on = [ aws_vpc.ada_vpc ]
}

resource "aws_subnet" "publica-b" {
  vpc_id = aws_vpc.ada_vpc.id
  cidr_block = var.cidrpublica-b
  availability_zone = "publica-b"

  tags = {
    name = "publica-b"
  }
  depends_on = [ aws_vpc.ada_vpc ]
}

resource "aws_subnet" "publica-c" {
  vpc_id = aws_vpc.ada_vpc.id
  cidr_block = var.cidrpublica-c

  tags = {
    name = "publica-c"
  }
  depends_on = [ aws_vpc.ada_vpc ]
}

resource "aws_internet_gateway" "gw-ada" {
  vpc_id = aws_vpc.ada_vpc.id

  tags = {
    Name = "gateway-ada"
  }
}

resource "aws_subnet" "privada-a" {
  vpc_id = aws_vpc.ada_vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "east-1"
  tags = {
    name = "privada-app-a"
  }
  depends_on = [ aws_vpc.ada_vpc ]
}

resource "aws_subnet" "privada-b" {
  vpc_id = aws_vpc.ada_vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "privada-b"

  tags = {
    name = "privada-app-b"
  }
  depends_on = [ aws_vpc.ada_vpc ]
}

resource "aws_subnet" "privada-c" {
  vpc_id = aws_vpc.ada_vpc.id
  cidr_block = "10.0.7.0/24"
  availability_zone = "c"
  tags = {
    name = "privada-app-c"
  }
  depends_on = [ aws_vpc.ada_vpc ]
}

resource "aws_nat_gateway" "aws_nat_gateway_a" {
  #allocation_id = aws_eip
  subnet_id     = aws_subnet.publica-a.id

  tags = {
    Name = "NAT-A"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw-ada]
}
resource "aws_nat_gateway" "aws_nat_gateway_b" {
  #allocation_id = aws_eip
  subnet_id     = aws_subnet.publica-b.id

  tags = {
    Name = "NAT-B"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw-ada]
}

resource "aws_nat_gateway" "aws_nat_gateway_c" {
  #allocation_id = aws_eip
  subnet_id     = aws_subnet.publica-c.id

  tags = {
    Name = "NAT-C"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw-ada]
}