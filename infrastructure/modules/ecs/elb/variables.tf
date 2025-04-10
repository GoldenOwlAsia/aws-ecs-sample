variable "service_name" {
  type = string
  description = "Service name"
}
variable "load_balancer_sg_id" {
  type = string
  description = "Security group ID for load balancer"
}
variable "load_balancer_subnet_list" {
  type = list(string)
  description = "List of subnet IDs"
}
variable "vpc_id" {
  type = string
  description = "VPC ID"
}
variable "ecs_port" {
  type = number
  description = "Port number for ECS container"
}
