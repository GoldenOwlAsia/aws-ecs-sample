output "elb_dns_" {
  value = module.elb.dns_name
}

output "cluster" {
  value = module.cluster.cluster
}

output "service" {
  value = module.service.service
}

output "task_definition" {
  value = module.task_definition.task_arn
}
