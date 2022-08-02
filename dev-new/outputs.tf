output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.dev_new_mongodb44.id
}

output "instance_private_ip" {
  description = "private IP address of the EC2 instance"
  value       = aws_instance.dev_new_mongodb44.private_ip
}
