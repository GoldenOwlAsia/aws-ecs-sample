variable "service_name" {
  type = string
  description = "ECS cluster and service name"
}
variable "region" {
  type = string
  description = "AWS Region for service"
  default = "ap-southeast-1"
}
