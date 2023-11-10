variable "aws_region" {
  description = "AWS region"
}

variable "common_tags" {
  type = map(string)
  default = {
    Terraform = "true"
  }
}

variable "ecs_task_definition_name" {
  description = "ECS task definition name"
}

variable "ecs_container_name" {
  description = "ECS task container name"
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
}

variable "ecs_service_name" {
  description = "ECS service name"
}
