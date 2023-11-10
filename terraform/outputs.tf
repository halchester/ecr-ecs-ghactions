output "ecr_repo_url" {
  value = module.vite_app_repository.repository_url
}

output "github_actions_user_access_key_id" {
  value = aws_iam_access_key.github_actions_user_access_key.id
}

output "github_actions_user_access_secret_key" {
  value     = aws_iam_access_key.github_actions_user_access_key.secret
  sensitive = true
}
