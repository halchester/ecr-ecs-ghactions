variable "ec2_instance_type" {
  description = "EC2 instance type"
}

variable "aws_region" {
  description = "AWS region"
}

variable "common_tags" {
  type = map(string)
  default = {
    Terraform = "true"
  }
}

variable "ec2_public_key" {
  description = "EC2 public key"
}
