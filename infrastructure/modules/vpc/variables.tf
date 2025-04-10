variable "vpc_name" {
  type = string
  description = "Application name"
}

variable "ingress_ports" {
  type = list(number)
  description = "Container exposed port"
}

variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "app_service_subnets" {
  description = "List of subnet and az"
  type = list(object({
    cidr_block = string
    availability_zone = string
  }))
  default = [
    {
      cidr_block = "10.0.1.0/24"
      availability_zone = "ap-southeast-1a"
    },
    {
      cidr_block = "10.0.2.0/24"
      availability_zone = "ap-southeast-1b"
    },
    {
      cidr_block = "10.0.3.0/24"
      availability_zone = "ap-southeast-1c"
    }
  ]
}

variable "app_elb_subnets" {
  description = "List of subnet and az"
  type = list(object({
    cidr_block = string
    availability_zone = string
  }))
  default = [
    {
      cidr_block = "10.0.4.0/24"
      availability_zone = "ap-southeast-1a"
    },
    {
      cidr_block = "10.0.5.0/24"
      availability_zone = "ap-southeast-1b"
    },
    {
      cidr_block = "10.0.6.0/24"
      availability_zone = "ap-southeast-1c"
    }
  ]
}
