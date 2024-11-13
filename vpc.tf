# VPC
resource "aws_vpc" "ada_vpc" {
  cidr_block = var.cidrvpc
  tags = {
    vpc  = "ada"
    name = "terraform-ada"
  }
}

# Subnets Públicas
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

# Internet Gateway
resource "aws_internet_gateway" "gw-ada" {
  vpc_id = aws_vpc.ada_vpc.id

  tags = {
    Name = "gateway-ada"
  }
}

# Subnets Privadas
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
resource "aws_subnet" "dados-a" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "dados-a"
  }
  depends_on = [aws_vpc.ada_vpc]
}
resource "aws_subnet" "dados-b" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.9.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "dados-b"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "dados-c" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "dados-c"
  }
  depends_on = [aws_vpc.ada_vpc]
}

# Elastic IPs para NAT Gateways
resource "aws_eip" "eip_nat_a" {
  depends_on = [aws_internet_gateway.gw-ada]
}

resource "aws_eip" "eip_nat_b" {
  depends_on = [aws_internet_gateway.gw-ada]
}

resource "aws_eip" "eip_nat_c" {
  depends_on = [aws_internet_gateway.gw-ada]
}

# NAT Gateways
resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.eip_nat_a.id
  subnet_id     = aws_subnet.publica-a.id
  tags = {
    Name = "NAT-A"
  }
  depends_on = [aws_internet_gateway.gw-ada]
}

resource "aws_nat_gateway" "nat_gateway_b" {
  allocation_id = aws_eip.eip_nat_b.id
  subnet_id     = aws_subnet.publica-b.id
  tags = {
    Name = "NAT-B"
  }
  depends_on = [aws_internet_gateway.gw-ada]
}

resource "aws_nat_gateway" "nat_gateway_c" {
  allocation_id = aws_eip.eip_nat_c.id
  subnet_id     = aws_subnet.publica-c.id
  tags = {
    Name = "NAT-C"
  }
  depends_on = [aws_internet_gateway.gw-ada]
}

# Tabelas de Rota para Subnets Públicas
resource "aws_route_table" "route-public" {
  vpc_id = aws_vpc.ada_vpc.id
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw-ada.id
  }
}

resource "aws_route_table" "banco" {
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_route_table_association" "dados-a" {
  subnet_id      = aws_subnet.dados-a.id
  route_table_id = aws_route_table.banco.id
}
resource "aws_route_table_association" "dados-b" {
  subnet_id      = aws_subnet.dados-b.id
  route_table_id = aws_route_table.banco.id
}
resource "aws_route_table_association" "dados-c" {
  subnet_id      = aws_subnet.dados-c.id
  route_table_id = aws_route_table.banco.id
}

resource "aws_route_table_association" "publica-a" {
  subnet_id      = aws_subnet.publica-a.id
  route_table_id = aws_route_table.route-public.id
}

resource "aws_route_table_association" "publica-b" {
  subnet_id      = aws_subnet.publica-b.id
  route_table_id = aws_route_table.route-public.id
}

resource "aws_route_table_association" "publica-c" {
  subnet_id      = aws_subnet.publica-c.id
  route_table_id = aws_route_table.route-public.id
}

# Tabelas de Rota para Subnets Privadas
resource "aws_route_table" "privada-a" {
  vpc_id = aws_vpc.ada_vpc.id
  route {
    cidr_block     = "10.0.0.0/16"
    nat_gateway_id = aws_nat_gateway.nat_gateway_a.id
  }
  route {
    cidr_block     = "0.0.0.0/16"
    nat_gateway_id = aws_nat_gateway.nat_gateway_a.id
  }
  tags = {
    name = "route-table-privada-a"
  }
}

resource "aws_route_table" "privada-b" {
  vpc_id = aws_vpc.ada_vpc.id
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_b.id
  }
  tags = {
    name = "route-table-privada-b"
  }
}

resource "aws_route_table" "privada-c" {
  vpc_id = aws_vpc.ada_vpc.id
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"

  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_c.id

  }
  tags = {
    name = "route-table-privada-c"
  }
}

# Associação de Tabelas de Rota Privadas
resource "aws_route_table_association" "app-a" {
  subnet_id      = aws_subnet.privada-a.id
  route_table_id = aws_route_table.privada-a.id
}

resource "aws_route_table_association" "route-table-privada-b" {
  subnet_id      = aws_subnet.privada-b.id
  route_table_id = aws_route_table.privada-b.id
}

resource "aws_route_table_association" "route-table-privada-c" {
  subnet_id      = aws_subnet.privada-c.id
  route_table_id = aws_route_table.privada-c.id
}
