output "rds_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.mydb.id
}

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.mydb.endpoint
}

output "rds_port" {
  description = "RDS Port"
  value       = aws_db_instance.mydb.port
}

output "rds_security_group_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds_sg.id
}

output "db_subnet_group" {
  description = "DB Subnet Group Name"
  value       = aws_db_subnet_group.db_subnet_group.name
}