data "aws_iam_role" "ecs_role" {
  name = var.ecs_role_name
}

resource "aws_cloudwatch_log_group" "app_ecs_log_group" {
  name = "/ecs/${var.service_name}"
}

resource "aws_ecs_task_definition" "app_task_def" {
  family = var.service_name
  container_definitions = <<TASK_DEFINITION
  [
  {
    "portMappings": [
      {
        "hostPort": ${var.container_port},
        "protocol": "tcp",
        "containerPort": ${var.container_port}
      }
    ],
    "cpu": ${var.cpu},
    "environment": ${jsonencode(var.env_variables)},
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${var.service_name}",
        "awslogs-region": "${var.region}",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "memory": ${var.memory},
    "image": "${var.image_url}",
    "essential": true,
    "name": "${var.service_name}"
  }
]
TASK_DEFINITION

  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  memory = var.memory
  cpu = var.cpu
  execution_role_arn = data.aws_iam_role.ecs_role.arn
  task_role_arn = data.aws_iam_role.ecs_role.arn

  tags = {
    Name = var.service_name
  }
}
