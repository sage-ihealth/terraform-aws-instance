resource "aws_instance" "dev_new_mongodb44" {
  ami           = "ami-3803a040"
#  the instance type to t2.micro, which qualifies for AWS' free tier.
  instance_type = "t2.medium"

  tags = {
    Name        = "${var.environment}.mongo4.4"
    Environment = "${var.environment}"
  }


  key_name = "${var.aws_key_name}"
  
  vpc_security_group_ids = [
    "sg-0570487a"]
  subnet_id = "subnet-69f52110"
  associate_public_ip_address = false
  source_dest_check = false
#   iam_instance_profile = "${var.environment}-ecs-instance-role"

#   passing user data to the instance that can be used to perform common automated configuration tasks and even run scripts after the instance starts. 
#   user_data  = "${data.template_file.mongodb_node1.rendered}"

#   ebs_block_device {
#     volume_size = 30
#     volume_type = "gp2"
#     encrypted = true
#     device_name = "/dev/sdb"
#   }

# When you launch an instance, the root device volume contains the image used to boot the instance.
  root_block_device { 
    volume_size = 30
    volume_type = "gp2"
  }
  
}

