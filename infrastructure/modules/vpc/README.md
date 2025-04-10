# Terraform module for custom VPC

## Features
- New VPC
- Subnets for application
- Subnets for ELB

## How to use it
```terraform
module "vpc" {
  source = "../../modules/vpc/custom_vpc"
  ingress_ports = [3000,22]
  vpc_name = var.vpc_name
  vpc_cidr_block = var.vpc_cidr_block
}
```

## Customization
| Variable                | Type            | Description                           | Default Value                    |
|-------------------------|-----------------|---------------------------------------|----------------------------------|
| vpc_name                | string          | Application name                      |                                  |
| ingress_ports           | list(number)    | Container exposed port                |                                  |
| region                  | string          | AWS region                            | "ap-southeast-1"                 |
| vpc_cidr_block          | string          | VPC CIDR block                        | "10.0.0.0/16"                    |
| app_service_subnets     | list(object)    | List of subnet and AZ for services    | See Default Values Below         |
| app_elb_subnets         | list(object)    | List of subnet and AZ for ELB         | See Default Values Below         |

**Default Values for app_service_subnets:**
```json
[
  {
    "cidr_block": "10.0.1.0/24",
    "availability_zone": "ap-southeast-1a"
  },
  {
    "cidr_block": "10.0.2.0/24",
    "availability_zone": "ap-southeast-1b"
  },
  {
    "cidr_block": "10.0.3.0/24",
    "availability_zone": "ap-southeast-1c"
  }
]
```

**Default Values for app_elb_subnets:**
```json
[
  {
    "cidr_block": "10.0.4.0/24",
    "availability_zone": "ap-southeast-1a"
  },
  {
    "cidr_block": "10.0.5.0/24",
    "availability_zone": "ap-southeast-1b"
  },
  {
    "cidr_block": "10.0.6.0/24",
    "availability_zone": "ap-southeast-1c"
  }
]
```
