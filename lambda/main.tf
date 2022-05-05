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


data "template_file" "mongodb_node1" {

  vars = {
    node_hostname             = "${var.node1_hostname}"
    node1_hostname            = "${var.node1_hostname}"
    node2_hostname            = "${var.node2_hostname}"
    node3_hostname            = "${var.node3_hostname}"
  }
}

resource "aws_lambda_function" "mongodb_backup_snapshot" {
  filename      = "lambda_snapshot.zip"
  function_name = "${var.environment}-mongodb-backup-snapshot"

  role = "${aws_iam_role.lambda_db_snapshot.arn}"

  handler          = "main.lambda_handler"
  source_code_hash = "${base64sha256(file("lambda_snapshot.zip"))}"
  timeout          = 5
  runtime          = "python3.6"
  description      = "Create snapshot of ${var.environment} MongoDB"

  vpc_config {
    subnet_ids         = ["${data.terraform_remote_state.vpc.private_subnet_ids[0]}"]
    security_group_ids = ["${aws_security_group.mongodb.id}"]
  }

  environment {
    variables = {
      ENVIRONMENT = "${var.environment}"
      DEVICE_NAME = "${var.ebs_device_name}"
      DB_HOST     = "mongodb://${var.node1_hostname}:27017,${var.node2_hostname}:27017,${var.node3_hostname}:27017"
      DB_DATABASE = "admin"
      DB_REPLSET  = "rs0.${var.environment}"
      DB_USER     = "${data.vault_generic_secret.admin_mongodb_username.data.value}"
      DB_PASSWORD = "${data.vault_generic_secret.admin_mongodb_password.data.value}"
    }
  }
}

