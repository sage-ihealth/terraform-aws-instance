output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_private_ip" {
  description = "private IP address of the EC2 instance"
  value       = aws_instance.app_server.private_ip
}
