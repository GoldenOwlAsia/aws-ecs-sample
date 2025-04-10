output "target_group" {
  value = aws_lb_target_group.ecs_tg
}

output "dns_name" {
  value = aws_lb.ecs_elb.dns_name
}
