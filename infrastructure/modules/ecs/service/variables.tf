variable "service_name" {
  type = string
  description = "ECS cluster and service name"
}
variable "region" {
  type = string
  description = "AWS Region for service"
  default = "ap-southeast-1"
}
variable "ecs_target_group" {
  type = string
  description = "Target group ID for autoscaling of ECS"
}
variable "ecs_subnet_list" {
  type        = list(string)
  description = "List of ECS subnets IDs"
}
variable "ecs_sg_id" {
  type = string
  description = "Security group ID for ECS"
}
variable "image_url" {
  type = string
  description = "The image url from ECR"
}
variable "container_port" {
  type = number
  description = "The export port of container"
}
variable "enable_load_balancer" {
  type = bool
  description = "Choose to use load balancer or not"
  default = true
}
variable "desired_count" {
  type = number
  description = "Choose the desired count for service"
  default = 1
}
variable "capacity_provider" {
  type = string
  description = "Launch type Fargate or FATGATE_SPOT"
  default = "FARGATE"
}
variable "platform_version" {
  type = string
  description = "Set version for launch type"
  default = "1.4.0"
}
variable "min_capacity" {
  type = number
  description = "Min capacity for autoscaling"
  default = 1
}
variable "max_capacity" {
  type = number
  description = "Max capacity for autoscaling"
  default = 2
}
variable "memory_limit_scaling" {
  type = number
  description = "Metric for maximum memory usage until scaling"
  default = 70
}
variable "cpu_limit_scaling" {
  type = number
  description = "Metric for maximum CPU usage until scaling"
  default = 70
}
variable "cluster_name" {
  description = "ID of cluster"
  type = string
}
variable "task_definition_arn" {
  description = "Task definition ARN"
  type = string
}
variable "service_discovery_arn" {
  description = "Service discovery ARN"
  type = string
  default = null
}
