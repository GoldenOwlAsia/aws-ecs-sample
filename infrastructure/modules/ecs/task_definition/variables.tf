variable "service_name" {
  type = string
  description = "ECS cluster and service name"
}
variable "region" {
  type = string
  description = "AWS Region for service"
  default = "ap-southeast-1"
}
variable "image_url" {
  type = string
  description = "The image url from ECR"
}
variable "container_port" {
  type = number
  description = "The export port of container"
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
  default = "512"
}
variable "cpu" {
  type = string
  description = "Memory usage for task"
  default = "512"
}
variable "ecs_role_name" {
  type = string
  description = "Role name for ECS execution"
  default = "ecsTaskExecutionRole"
}
