module "elb" {
  source = "./elb"
  ecs_port = var.container_port
  load_balancer_sg_id = var.elb_sg_id
  load_balancer_subnet_list = var.elb_subnet_list_id
  vpc_id = var.vpc_id
  service_name = var.service_name
}

module "cluster" {
  source = "./cluster"
  service_name = var.service_name
}

module "task_definition" {
  source = "./task_definition"
  container_port = var.container_port
  env_variables = var.env_variables
  cpu = var.cpu
  ecs_role_name = var.ecs_role_name
  image_url = var.image_url
  memory = var.memory
  service_name = var.service_name
}

module "service" {
  source = "./service"
  cluster_name = module.cluster.cluster_name
  container_port = var.container_port
  ecs_sg_id = var.ecs_service_sg_id
  ecs_subnet_list = var.service_subnet_list_id
  ecs_target_group = module.elb.target_group.arn
  enable_load_balancer = var.enable_load_balancer
  image_url = var.image_url
  service_name = var.service_name
  task_definition_arn = module.task_definition.task_arn
}
