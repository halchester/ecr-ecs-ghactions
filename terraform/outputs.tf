output "ecr_uri" {
  value = module.blog_resources_repository.repository_url
}

output "ecr_arn" {
  value = module.blog_resources_repository.repository_arn
}

# output "ecr_user_access_key" {
#   value = aws_iam_access_key.ecr_user.id
# }

# output "ecr_user_secret_key" {
#   value     = aws_iam_access_key.ecr_user.secret
#   sensitive = true
# }
