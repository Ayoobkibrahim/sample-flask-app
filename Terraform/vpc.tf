module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "task-3-49-vpc"
  cidr = "10.0.0.0/16"

  azs            = [data.aws_availability_zones.available.names[0]]
  public_subnets = ["10.0.1.0/24"]

  public_subnet_names = ["task-3-49-public-subnet"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = false

  map_public_ip_on_launch = true

  manage_default_route_table    = false
  manage_default_security_group = false

  tags = { Task = "3-49" }
}