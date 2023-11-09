# VPC
module "vite_app_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "vite-app-vpc"
  cidr = "10.0.0.0/16"

  azs                     = ["eu-west-1a"]
  public_subnets          = ["10.0.1.0/24"]
  map_public_ip_on_launch = true

  tags = var.common_tags
}
