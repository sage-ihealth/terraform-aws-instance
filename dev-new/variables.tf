variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "SageExampleAppServerInstance"
}

variable "environment" {}
variable "aws_region" {}
variable "aws_key_name" {}
variable "aws_key_path" {}
variable "availability_zone_a" {}
variable "availability_zone_b" {}
variable "availability_zone_c" {}


variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "app_base_amis" {
  default = {
    us-west-2 = "ami-3803a040"
  }
}


variable "ebs_volume_type" {
  description = "Storage type of EBS volumes, if used (default gp2)"
  default     = "gp2"
}

variable "node_hostname" {}

