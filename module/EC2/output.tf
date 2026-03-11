output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "ec2_private_ip" {
  description = "Private IP of EC2"
  value       = aws_instance.app_server.private_ip
}