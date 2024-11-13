data "aws_instances" "current_instances" {
  instance_state_names = ["running"]
}

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


resource "aws_lb_target_group_attachment" "attach_lb" {
  for_each         = toset(data.aws_instances.current_instances.ids)
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = each.value
  port             = 80
}

resource "aws_lb" "lb_instance" {
  name               = "load-balancer"
  internal           = false
  load_balancer_type = "application"
  subnets = [aws_subnet.publica-a.id, aws_subnet.publica-b,
  aws_subnet.publica-c]

  security_groups = [aws_security_group.allow_lb.id]

  depends_on = [aws_route_table.route-public]

  tags = {
    Name = "load-balancer"
  }
}