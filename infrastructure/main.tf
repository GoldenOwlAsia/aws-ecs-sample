module "vpc" {
  source = "./modules/vpc"
  ingress_ports = [var.container_port]
  vpc_name = var.vpc_name
  vpc_cidr_block = var.vpc_cidr_block
  app_service_subnets = var.app_service_subnets
  app_elb_subnets = var.app_elb_subnets
}

module "ecr" {
  source = "./modules/ecr"
  repository_name = "hcmus-seminar"
  max_image_count = 5
}

module "ecs" {
  source = "./modules/ecs"
  container_port = var.container_port
  cpu = var.cpu
  ecs_role_name = var.ecs_role_name
  ecs_service_sg_id = module.vpc.service_sg.id
  elb_sg_id = module.vpc.elb_sg.id
  elb_subnet_list_id = slice(module.vpc.elb_subnet_list, 0, 2)
  enable_load_balancer = false
  image_url = var.image_url
  memory = var.memory
  service_name = var.service_name
  service_subnet_list_id = slice(module.vpc.service_subnet_list, 0, 2)
  vpc_id = module.vpc.vpc.id
  enable_service_discovery = true
  service_discovery_name = "fe"
  service_discovery_namespace_id = 1
}
