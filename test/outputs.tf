output "instance1_id" {
  description = "ID of the EC2 instance 1"
  value       = aws_instance.sage_test_mongodb_node1.id
}

output "instance1_private_ip" {
  description = "private IP address of the EC2 instance 1"
  value       = aws_instance.sage_test_mongodb_node1.private_ip
}

output "instance2_id" {
  description = "ID of the EC2 instance 2"
  value       = aws_instance.sage_test_mongodb_node2.id
}

output "instance2_private_ip" {
  description = "private IP address of the EC2 instance 2"
  value       = aws_instance.sage_test_mongodb_node2.private_ip
}
output "instance3_id" {
  description = "ID of the EC2 instance 3"
  value       = aws_instance.sage_test_mongodb_node3.id
}

output "instance3_private_ip" {
  description = "private IP address of the EC2 instance 3"
  value       = aws_instance.sage_test_mongodb_node3.private_ip
}
