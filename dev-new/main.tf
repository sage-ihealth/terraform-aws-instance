terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-3803a040"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }

  key_name = "${var.aws_key_name}"
  
  vpc_security_group_ids = [
    "sg-0570487a"]
  subnet_id = "subnet-69f52110"
  associate_public_ip_address = false
  source_dest_check = false
  # iam_instance_profile = "${var.environment}-ecs-instance-role"

  ebs_block_device {
    volume_size = 8
    volume_type = "gp2"
    encrypted = true
    device_name = "/dev/sdb"
  }

# When you launch an instance, the root device volume contains the image used to boot the instance.
  root_block_device { 
    volume_size = 8
    volume_type = "gp2"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get -y install percona-server-mongodb-34"
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip
      private_key = "${file("${var.aws_key_path}")}"
    }
  }
}

