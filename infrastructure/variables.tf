variable "aws_profile" {
  type = string
  description = "AWS profile name"
}
variable "vpc_name" {
  type = string
  description = "Application name"
}
variable "container_port" {
  type = number
}
variable "vpc_cidr_block" {
    type = string
    description = "CIDR block for the new VPC"
    default = "10.0.0.0/16"
}
variable "region" {
  type = string
  description = "AWS Region for service"
  default = "ap-southeast-1"
}
variable "app_service_subnets" {
  description = "List of subnet and az"
  type = list(object({
    cidr_block = string
    availability_zone = string
  }))
  default = []
}
variable "app_elb_subnets" {
  description = "List of subnet and az"
  type = list(object({
    cidr_block = string
    availability_zone = string 
  }))
  default = []
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
}
variable "service_discovery_dns" {
  type = string
  description = "The dns for service discovery"
}
variable "enable_service_discovery" {
  type = bool
  description = "Choose to use service discovery or not"
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
  default = 1
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