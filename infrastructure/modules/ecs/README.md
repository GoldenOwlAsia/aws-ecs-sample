# Terraform module for AWS ECS running on FARGATE
This module creates an ECS cluster and a set of EC2 instances to run the ECS agents.

## Available features
- Create task definition
- Create ECS cluster
- Create ECS service
- Create load balancer
- Using as separate module

## Setup
### Service role for ECS:
Create an ECS task execution role with sufficient permissions for running task. Use this name for later step
![ECS role](img/ecs_role.png)
### Create instance profile for EC2
Use this profile name for later step
![EC2 instance profile](img/instance_profile.png)
### Set up VPC for cluster
Inside ingress port type in the list of port that you want to open
```terraform
module "vpc" {
  source = "../../modules/vpc/custom_vpc"
  ingress_ports = [var.container_port_fe,22]
  vpc_name = var.vpc_name
  vpc_cidr_block = var.vpc_cidr_block
}
```
### Set up cluster, task definition and service
```terraform
module "ecs" {
  source = "modules/ecs/ecs_ec2"
  container_port = var.container_port_fe
  ecs_role_name = var.ecs_execution_role
  ecs_service_sg_id = module.vpc.service_sg.id
  elb_sg_id = module.vpc.elb_sg.id
  elb_subnet_list_id = slice(module.vpc.elb_subnet_list, 0, 3)
  image_url = var.image_url
  service_name = var.service_name
  service_subnet_list_id = slice(module.vpc.service_subnet_list, 0, 3)
  vpc_id = module.vpc.vpc.id
  instance_type = "t2.micro"
  path_to_ssh_key = "~/.ssh/id_ed25519.pub"
  ec2_instance_role_profile_name = "ec2-instance-profile-for-ecs"
}
```
## Customization
| Variable                       | Type            | Description                                          | Default Value          |
|--------------------------------|-----------------|------------------------------------------------------|------------------------|
| vpc_id                         | string          | VPC used for                                         | Import from VPC module |
| elb_sg_id                      | string          | Security group id for load balancer                   | Import from VPC module                       |
| ecs_service_sg_id               | string          | Security group id for ECS Service                    | Import from VPC module                       |
| service_subnet_list_id          | list(string)    | Subnet list id for service                           | Import from VPC module                       |
| elb_subnet_list_id              | list(string)    | Subnet list id for load balancer                      | Import from VPC module                       |
| container_port                  | number          | Exposed port of container                             |                        |
| service_name                    | string          | Service name                                         |                        |
| image_url                       | string          | The image URL from ECR                               |                        |
| env_variables                   | list(object)    | Map of environment variables                         | []                     |
| memory                          | string          | Memory usage for task                                | "512"                  |
| cpu                             | string          | Memory usage for task                                | "512"                  |
| enable_load_balancer            | bool            | Choose to use load balancer or not                   | true                   |
| enable_service_discovery        | bool            | Choose to use service discovery or not               | false                  |
| service_discovery_namespace_id  | string          | ID of Cloud Map namespace                            | "none"                 |
| service_discovery_name          | string          | The name for DNS service for discovery               | "none"                 |
| desired_count                   | number          | Choose the desired count for service                 | 1                      |
| min_capacity                    | number          | Min capacity for autoscaling                         | 1                      |
| max_capacity                    | number          | Max capacity for autoscaling                         | 2                      |
| memory_limit_scaling            | number          | Metric for maximum memory usage until scaling        | 70                     |
| cpu_limit_scaling               | number          | Metric for maximum CPU usage until scaling           | 70                     |
| ecs_role_name                   | string          | Role name for ECS execution                          | "ecsTaskExecutionRole" |

