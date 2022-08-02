
data "template_file" "mongodb_node3" {
  template = "${file("${path.module}/cloud-init.mongodb.ubuntu.yml")}"

  vars = {
    node_hostname             = "${var.node3_hostname}"
  }
}

resource "aws_instance" "node3_prod_mongo4_4" {
  ami           = "ami-dc8d97a5"
  instance_type = "r5.xlarge"

  tags = {
    Name        = "node3.prod.mongo4.4"
    Hostname    = "${var.node3_hostname}"
    Environment = "${var.environment}"
  }


  key_name = "${var.aws_key_name}"
  
  vpc_security_group_ids = [
    "sg-65e96f14"]
  subnet_id = "subnet-1c1f8565"
  associate_public_ip_address = false
  source_dest_check = false
  # iam_instance_profile = "${var.environment}-ecs-instance-role"
  user_data  = "${data.template_file.mongodb_node3.rendered}"

  # ebs_block_device {
  #   volume_size = 32
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

