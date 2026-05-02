variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "docker_image" {
  type        = string
  description = "Container image for the ECS task, e.g. dockerhub-user/repo:tag"
}

variable "github_org" {
  type = string
}

variable "github_repo" {
  type = string
}