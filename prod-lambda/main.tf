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


resource "aws_lambda_function" "sage_test_mongodb_backup_snapshot" {
  filename      = "lambda_snapshot.zip"
  function_name = "${var.environment}-mongodb44-backup-snapshot"

  role = "arn:aws:iam::358153424697:role/${var.environment}-lambda-mongodb-snapshot-role"

  handler          = "main.lambda_handler"
  source_code_hash = "${base64sha256("lambda_snapshot.zip")}"
  timeout          = 5
  runtime          = "python3.6"
  description      = "Create snapshot of ${var.environment} MongoDB"

  vpc_config {
    subnet_ids         = ["subnet-1c1f8565"]
    security_group_ids = ["sg-65e96f14"]
  }

  environment {
    variables = {
      ENVIRONMENT = "${var.environment}"
      DEVICE_NAME = "${var.ebs_device_name}"
      DB_HOST     = "mongodb://${var.node1_hostname}:27017,${var.node2_hostname}:27017,${var.node3_hostname}:27017"
      DB_DATABASE = "admin"
      DB_REPLSET  = "rs0.${var.environment}"
      DB_USER     = "admin"
      DB_PASSWORD = "iHealth.Next"
    }
  }
}

