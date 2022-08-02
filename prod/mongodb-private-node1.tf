
data "template_file" "mongodb_node1" {
  template = "${file("${path.module}/cloud-init.mongodb.ubuntu.yml")}"

  vars = {
    node_hostname             = "${var.node1_hostname}"
  }
}

resource "aws_instance" "node1_prod_mongo4_4" {
  ami           = "ami-dc8d97a5"
  instance_type = "r5.xlarge"

  tags = {
    Name        = "node1.prod.mongo4.4"
    Hostname    = "${var.node1_hostname}"
    Environment = "${var.environment}"
  }


  key_name = "${var.aws_key_name}"
  
  vpc_security_group_ids = [
    "sg-65e96f14"]
  subnet_id = "subnet-1c1f8565"
  associate_public_ip_address = false
  source_dest_check = false
  # iam_instance_profile = "${var.environment}-ecs-instance-role"
  user_data  = "${data.template_file.mongodb_node1.rendered}"

  # ebs_block_device {
  #   volume_size = 50
  #   volume_type = "gp2"
  #   encrypted = true
  #   device_name = "/dev/sdb"
  # }

# When you launch an instance, the root device volume contains the image used to boot the instance.
  root_block_device { 
    volume_size = 30
    volume_type = "gp2"
  }
  
}

