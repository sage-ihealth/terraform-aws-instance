
data "template_file" "mongodb_node1" {
  template = "${file("${path.module}/cloud-init.mongodb.ubuntu.yml")}"

  vars = {
    node_hostname             = "${var.node1_hostname}"
    node1_hostname            = "${var.node1_hostname}"
    node2_hostname            = "${var.node2_hostname}"
    node3_hostname            = "${var.node3_hostname}"
  }
}


resource "aws_instance" "sage_test_mongodb_node1" {
  ami           = "ami-dc8d97a5"
  instance_type = "t2.medium"

  tags = {
    Name        = "sage_${var.environment}_mongodb_node1"
    Environment = "${var.environment}"
  }


  key_name = "${var.aws_key_name}"
  
  vpc_security_group_ids = [
    "sg-cca041bd"]
  subnet_id = "subnet-6126b318"
  associate_public_ip_address = false
  source_dest_check = false
  # iam_instance_profile = "${var.environment}-ecs-instance-role"
  user_data  = "${data.template_file.mongodb_node1.rendered}"

  ebs_block_device {
    volume_size = 30
    volume_type = "gp2"
    encrypted = true
    device_name = "/dev/sdb"
  }

# When you launch an instance, the root device volume contains the image used to boot the instance.
  root_block_device { 
    volume_size = 30
    volume_type = "gp2"
  }
  
}

