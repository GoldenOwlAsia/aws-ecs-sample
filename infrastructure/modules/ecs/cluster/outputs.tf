output "cluster_name" {
  value = aws_ecs_cluster.app_ecs_cluster.name
}

output "cluster" {
  value = aws_ecs_cluster.app_ecs_cluster
}
