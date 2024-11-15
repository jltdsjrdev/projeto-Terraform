# Carregar instâncias existentes na VPC
data "aws_instances" "current_instances" {
  instance_state_names = ["running"]
}

# Definir o Target Group para o Load Balancer
resource "aws_lb_target_group" "lb_target_group" {
  name     = "load-balancer-target-group"
  port     = 80
  protocol = "HTTPS"
  vpc_id   = aws_vpc.ada_vpc.id

  health_check {
    path     = "/"
    protocol = "HTTPS"
  }
}

# Associar o Target Group às instâncias
resource "aws_lb_target_group_attachment" "attach_lb" {
  for_each         = toset(data.aws_instances.current_instances.ids)
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = each.value
  port             = 80
}

# Criar o Load Balancer
resource "aws_lb" "lb_instance" {
  name               = "load-balancer"
  internal           = false
  load_balancer_type = "application"
  subnets = [
    aws_subnet.publica-a.id,
    aws_subnet.publica-b.id,
    aws_subnet.publica-c.id
  ]

  security_groups = [aws_security_group.allow_lb.id]

  depends_on = [aws_route_table_association.publica-a, aws_route_table_association.publica-b, aws_route_table_association.publica-c]

  tags = {
    Name = "load-balancer"
  }
}
