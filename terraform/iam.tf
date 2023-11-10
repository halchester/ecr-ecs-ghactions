# ECS Task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
  tags = var.common_tags
}

resource "aws_iam_policy_attachment" "ecs_task_execution_role_policy_attach" {
  name = "ecs-task-execution-role-policy-attach"
  roles = [
    aws_iam_role.ecs_task_execution_role.name
  ]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Github action IAM User
resource "aws_iam_user" "github_actions_user" {
  name = "github-actions-user"
  tags = var.common_tags
}

resource "aws_iam_access_key" "github_actions_user_access_key" {
  user = aws_iam_user.github_actions_user.name
}

resource "aws_iam_policy" "github_actions_user_access_policy" {
  name = "github-actions-user-access-policy"
  depends_on = [
    module.vite_app_repository,
    aws_ecs_service.vite_app_service,
    aws_iam_role.ecs_task_execution_role
  ]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-push.html
        Effect = "Allow",
        Action = [
          "ecr:CompleteLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:InitiateLayerUpload",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage"
        ],
        Resource = [module.vite_app_repository.repository_arn]
      },
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken"
        ],
        Resource = ["*"]
      },
      {
        Effect = "Allow",
        Action = [
          "ecs:DescribeTaskDefinition",
          "ecs:RegisterTaskDefinition",
          "ecs:DescribeServices",
          "ecs:UpdateService"
        ],
        Resource = [
          "*",
          aws_ecs_service.vite_app_service.id
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "iam:PassRole"
        ],
        Resource = [aws_iam_role.ecs_task_execution_role.arn],
        Condition = {
          StringEquals = {
            "iam:PassedToService" : "ecs-tasks.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "github_actions_user_policy_attach" {
  name = "github-actions-user-policy-attach"
  users = [
    aws_iam_user.github_actions_user.name
  ]
  policy_arn = aws_iam_policy.github_actions_user_access_policy.arn
}
