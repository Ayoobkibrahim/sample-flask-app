module "ecs_cluster" {
  source  = "terraform-aws-modules/ecs/aws//modules/cluster"
  version = "~> 5.11"

  cluster_name = "task-3-49-cluster"

  tags = { Name = "task-3-49-cluster", Task = "3-49" }
}

resource "aws_iam_role" "ecs_task_execution" {
  name = "task-3-49-ecs-task-execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "task-3-49-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([{
    name      = "app"
    image     = var.docker_image
    essential = true
    portMappings = [{
      containerPort = 5000
      hostPort      = 5000
      protocol      = "tcp"
    }]
  }])

  tags = { Task = "3-49" }
}

resource "aws_ecs_service" "app" {
  name            = "task-3-49-service"
  cluster         = module.ecs_cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count     = 1
  launch_type       = "FARGATE"

  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [aws_security_group.task_3_49.id]
    assign_public_ip = true
  }

  tags = { Task = "3-49" }
}