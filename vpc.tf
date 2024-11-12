resource "aws_vpc" "ada_vpc" {
  cidr_block = var.cidrvpc

  tags = {
    vpc  = "ada"
    name = "terraform-ada"
  }
}

resource "aws_subnet" "publica-a" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = var.cidrpublica-a
  availability_zone = "us-east-1a"
  tags = {
    name = "publica-a"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "publica-b" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = var.cidrpublica-b
  availability_zone = "us-east-1b"

  tags = {
    name = "publica-b"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "publica-c" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = var.cidrpublica-c
  availability_zone = "us-east-1c"

  tags = {
    name = "publica-c"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_internet_gateway" "gw-ada" {
  vpc_id = aws_vpc.ada_vpc.id

  tags = {
    Name = "gateway-ada"
  }
}

resource "aws_subnet" "privada-a" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"
  tags = {
    name = "privada-app-a"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "privada-b" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1b"

  tags = {
    name = "privada-app-b"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "privada-c" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-1c"
  tags = {
    name = "privada-app-c"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_nat_gateway" "aws_nat_gateway_a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.publica-a.id

  tags = {
    Name = "NAT-A"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw-ada]
}

resource "aws_nat_gateway" "nat_eip_a" {

}
resource "aws_nat_gateway" "aws_nat_gateway_b" {
  #allocation_id = aws_eip
  subnet_id = aws_subnet.publica-b.id

  tags = {
    Name = "NAT-B"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw-ada]
}

resource "aws_nat_gateway" "aws_nat_gateway_c" {
  allocation_id = aws_eip
  subnet_id     = aws_subnet.publica-c.id

  tags = {
    Name = "NAT-C"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw-ada]
}

#Elastic ip
resource "aws_eip" "eip-nat-publica-a" {
  depends_on = [aws_internet_gateway.gw-ada]
}

resource "aws_eip" "eip-nat-publica-b" {
  depends_on = [aws_internet_gateway.gw-ada]
}

resource "aws_eip" "eip-nat-publica-c" {
  depends_on = [aws_internet_gateway.gw-ada]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ada_vpc.id

  route = {
    cidr_block = "10.0.0.0/16"
    gateway_id = "aws"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw-ada.id
  }
}

resource "aws_route_table_association" "publica-a" {
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "publica-b" {
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "publica-c" {
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "aws_route_table_privada-a" {
  vpc_id = aws_vpc.ada_vpc.id
  route {
    cidr_block     = aws_internet_gateway.gw-ada.id
    nat_gateway_id = aws_nat_gateway.aws_nat_gateway_a.id
  }
  route {
    cidr_block = var.cidrvpc
    gateway_id = "local"
  }
  tags = {
    name = "route-table-privada-a"
  }
}
resource "aws_route_table" "aws_route_table_privada-b" {
  vpc_id = aws_vpc.ada_vpc.id
  route {
    cidr_block     = aws_internet_gateway.gw-ada.id
    nat_gateway_id = aws_nat_gateway.aws_nat_gateway_b.id
  }
  route {
    cidr_block = var.cidrvpc
    gateway_id = "local"
  }
  tags = {
    name = "route-table-privada-b"
  }
}
resource "aws_route_table" "aws_route_table_privada-c" {
  vpc_id = aws_vpc.ada_vpc.id
  route {
    cidr_block     = aws_internet_gateway.gw-ada.id
    nat_gateway_id = aws_nat_gateway.aws_nat_gateway_c.id
  }
  route {
    cidr_block = var.cidrvpc
    gateway_id = "local"
  }
  tags = {
    name = "route-table-privada-c"
  }
}

resource "aws_route_table_association" "route-table-privada-a" {
  subnet_id      = aws_subnet.privada-a.id
  route_table_id = aws_route_table.aws_route_table_privada-a.id
}

resource "aws_route_table_association" "route-table-privada-b" {
  subnet_id      = aws_subnet.privada-b.id
  route_table_id = aws_route_table.aws_route_table_privada-b.id
}
resource "aws_route_table_association" "route-table-privada-c" {
  subnet_id      = aws_subnet.privada-c.id
  route_table_id = aws_route_table.aws_route_table_privada-c.id
}

resource "aws_route_table" "banco" {
  vpc_id = aws_vpc.ada_vpc.id

  route {

  }
}