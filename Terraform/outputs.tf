output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}

output "ecs_service_arn" {
  value = aws_ecs_service.app.arn
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}