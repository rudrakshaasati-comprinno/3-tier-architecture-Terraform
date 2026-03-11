output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "List of private app subnet IDs"
  value       = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  description = "List of private DB subnet IDs"
  value       = module.vpc.private_db_subnet_ids
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = module.vpc.internet_gateway_id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = module.vpc.nat_gateway_id
}

#--------------ec2 output----------
output "ec2_instance_id" {
  description = "EC2 instance created in private subnet"
  value       = module.ec2.ec2_instance_id
}

output "ec2_private_ip" {
  description = "Private IP of EC2 instance"
  value       = module.ec2.ec2_private_ip
}