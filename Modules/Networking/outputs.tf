
output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "subnet_info" {
  value = aws_subnet.subnets
}

output "security_group" {
    value = aws_security_group.default
}