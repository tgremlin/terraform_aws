output "vpc_id_out" {
    value = module.vpc.vpc_id
}

output "subnet_info_out" {
    value = module.vpc.subnet_info
}

output "vpc_sg_out" {
    value = module.vpc.security_group
}