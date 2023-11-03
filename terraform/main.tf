
module "blog_resources_repository" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "1.6.0"

  repository_name         = "blog-resources-repository"
  repository_type         = "private"
  create_lifecycle_policy = false

  tags = merge(var.common_tags)
}

resource "aws_iam_user" "ecr_user" {
  name = "ecr-user"
  tags = var.common_tags
}

resource "aws_iam_access_key" "ecr_user" {
  user = aws_iam_user.ecr_user.name
}

resource "aws_iam_user_policy" "ecr_access_policy" {
  name   = "ecr-access-policy"
  user   = aws_iam_user.ecr_user.name
  policy = data.aws_iam_policy_document.ecr_user_policies.json
}
