resource "aws_security_group" "task_3_49" {
  name        = "task-3-49-sg"
  description = "Flask port 5000"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP Flask"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "task-3-49-sg", Task = "3-49" }
}