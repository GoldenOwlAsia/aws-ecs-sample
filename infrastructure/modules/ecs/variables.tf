variable "vpc_id" {
  description = "VPC used for"
}
variable "elb_sg_id" {
  type = string
  description = "Security group id for load balancer"
}
variable "ecs_service_sg_id" {
  type = string
  description = "Security group id for ECS Service"
}
variable "service_subnet_list_id" {
  type = list(string)
  description = "Subnet list id for service"
}
variable "elb_subnet_list_id" {
  type = list(string)
  description = "Subnet list id for load balancer"
}
variable "container_port" {
  type = number
  description = "Exposed port of container"
}
variable "service_name" {
  type = string
  description = "Service name"
}
variable "image_url" {
  type = string
  description = "The image url from ECR"
}
variable "env_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "Map of environment variables"
  default = []
}
variable "memory" {
  type = string
  description = "Memory usage for task"
}
variable "cpu" {
  type = string
  description = "Memory usage for task"
}
variable "enable_load_balancer" {
  type = bool
  description = "Choose to use load balancer or not"
  default = true
}
variable "enable_service_discovery" {
  type = bool
  description = "Choose to use service discovery or not"
}
variable "service_discovery_namespace_id" {
  type = string
  description = "Id of cloud map namespace"
  default = ""
}
variable "service_discovery_name" {
  type = string
  description = "The name for dns service for discovery"
  default = ""
}
variable "desired_count" {
  type = number
  description = "Choose the desired count for service"
  default = 1
}
variable "launch_type" {
  type = string
  description = "Launch type Fargate or EC2"
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
variable "capacity_provider" {
  type = string
  description = "Launch type Fargate or FATGATE_SPOT"
  default = "FARGATE"
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
variable "ecs_role_name" {
  type = string
  description = "Role name for ECS execution"
}
