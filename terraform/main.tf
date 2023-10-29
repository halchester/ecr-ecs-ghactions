
module "ec2_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "my-vite-app-vpc"
  cidr = "10.0.0.0/16"

  azs            = ["eu-west-1a"]
  public_subnets = ["10.0.1.0/24"]

  tags = var.common_tags
}

module "ec2_security_group" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "5.1.0"
  name        = "my-vite-app-sg"
  description = "Security group for my-vite-app with SSH, HTTP, and HTTPS ports open within VPC"

  vpc_id = module.ec2_vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  ingress_with_cidr_blocks = [
    {
      description = "Allow SSH access"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "Allow HTTP access"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "Allow HTTPS access"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = var.common_tags
}

resource "aws_key_pair" "ec2_ssh_key" {
  key_name   = "ec2_ssh_key"
  public_key = var.ec2_public_key
}

module "ec2_app" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "5.5.0"
  name                        = "my-vite-app"
  instance_type               = var.ec2_instance_type
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true

  vpc_security_group_ids = [module.ec2_security_group.security_group_id]
  subnet_id              = module.ec2_vpc.public_subnets[0]
  key_name               = "ec2_ssh_key"

  tags = merge(
    var.common_tags,
    { Name = "my-vite-app" }
  )
}
