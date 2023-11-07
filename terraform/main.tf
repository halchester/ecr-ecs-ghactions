
module "blog_resources_repository" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "1.6.0"

  repository_name                 = "blog-resources-repository"
  repository_type                 = "private"
  repository_image_tag_mutability = "MUTABLE"
  create_lifecycle_policy         = false

  tags = merge(var.common_tags)
}

resource "aws_ecs_cluster" "vite_app_cluster" {
  name = "vite-app-cluster"
  tags = var.common_tags
}

