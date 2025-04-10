output "vpc" {
  value = aws_vpc.app_vpc
}
output "service_subnet_list" {
  value = aws_subnet.app_public_subnet_list[*].id
}
output "elb_subnet_list" {
  value = aws_subnet.app_elb_subnet_list[*].id
}
output "elb_sg" {
  value = aws_security_group.app_service_elb_sg
}
output "service_sg" {
  value = aws_security_group.app_service_sg
}
