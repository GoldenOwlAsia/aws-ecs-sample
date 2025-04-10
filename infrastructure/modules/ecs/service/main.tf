resource "aws_ecs_service" "app_ecs_service" {
  name = var.service_name
  cluster = var.cluster_name
  task_definition =var.task_definition_arn
  desired_count = var.desired_count
  platform_version = var.platform_version

  lifecycle {
    ignore_changes = [desired_count]
  }

  network_configuration {
    subnets = var.ecs_subnet_list
    security_groups = [var.ecs_sg_id]
    assign_public_ip = true
  }

  capacity_provider_strategy {
    capacity_provider = var.capacity_provider
    weight = 1
  }

  # dynamic "load_balancer" {
  #   for_each = var.enable_load_balancer ? [1] : []
  #   content {
  #     target_group_arn = var.ecs_target_group
  #     container_name = var.service_name
  #     container_port = var.container_port
  #   }
  # }

  load_balancer {
    target_group_arn = var.ecs_target_group
    container_name = var.service_name
    container_port = var.container_port
  }

  dynamic "service_registries" {
    for_each = var.service_discovery_arn != null ? [1] : []
    content {
      registry_arn = var.service_discovery_arn
    }
  }
}

resource "aws_appautoscaling_target" "app_asl_target" {
  max_capacity = var.max_capacity
  min_capacity = var.min_capacity
  resource_id = "service/${var.cluster_name}/${aws_ecs_service.app_ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "dev_to_memory" {
  name               = "dev-to-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.app_asl_target.id
  scalable_dimension = aws_appautoscaling_target.app_asl_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.app_asl_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = var.memory_limit_scaling
  }
}

resource "aws_appautoscaling_policy" "dev_to_cpu" {
  name = "dev-to-cpu-be"
  policy_type = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.app_asl_target.id
  scalable_dimension = aws_appautoscaling_target.app_asl_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.app_asl_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = var.cpu_limit_scaling
  }
}

