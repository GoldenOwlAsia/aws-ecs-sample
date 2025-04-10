resource "aws_ecs_cluster" "app_ecs_cluster" {
  name = var.service_name
  setting {
    name = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = var.service_name
  }
}
