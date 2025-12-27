# ALB
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

# EC2
output "app_instance_ids" {
  value = module.ec2.instance_ids
}

output "app_instance_private_ips" {
  value = module.ec2.private_ips
}

# VPC
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

# RDS
output "rds_endpoint" {
  value = module.rds.rds_endpoint
}
