resource "aws_lb" "ecs_elb" {
  name               = "${var.service_name}-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.load_balancer_sg_id]
  subnets            = var.load_balancer_subnet_list

  tags = {
    Name = var.service_name
  }
}

resource "aws_lb_target_group" "ecs_tg" {
  name     = "${var.service_name}-target-sgroup"
  port     = var.ecs_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name = var.service_name
  }
}

resource "aws_lb_listener" "ecs_elb_listener" {
  load_balancer_arn = aws_lb.ecs_elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}
