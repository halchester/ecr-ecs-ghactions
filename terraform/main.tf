
module "vite_app_repository" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "1.6.0"

  repository_name                 = "vite-app-repository"
  repository_type                 = "private"
  repository_image_tag_mutability = "IMMUTABLE"
  create_lifecycle_policy         = true

  # only keep the latest 5 images
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire images by count"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 5
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = merge(var.common_tags)
}

resource "aws_ecs_cluster" "vite_app_cluster" {
  name = "vite-app-cluster"
  tags = var.common_tags
}

