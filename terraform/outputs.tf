output "ecr_uri" {
  value = module.vite_app_repository.repository_url
}

output "ecr_arn" {
  value = module.vite_app_repository.repository_arn
}

# output "ecr_user_access_key" {
#   value = aws_iam_access_key.ecr_user_access_key.id
# }

# output "ecr_user_secret_key" {
#   value     = aws_iam_access_key.ecr_user_access_key.secret
#   sensitive = true
# }
