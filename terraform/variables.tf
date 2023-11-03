variable "aws_region" {
  description = "AWS region"
}

variable "common_tags" {
  type = map(string)
  default = {
    Terraform = "true"
  }
}
