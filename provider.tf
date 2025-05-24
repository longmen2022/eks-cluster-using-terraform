locals {
  region           = "us-east-1"  # AWS region
  name             = "Long-Men-Cluster"  # Cluster name
  vpc_cidr         = "10.123.0.0/16"  # CIDR block for VPC
  azs              = ["us-east-1a", "us-east-1b"]  # Availability zones
  public_subnets   = ["10.123.1.0/24", "10.123.2.0/24"]  # Public subnets
  private_subnets  = ["10.123.3.0/24", "10.123.4.0/24"]  # Private subnets
  intra_subnets    = ["10.123.5.0/24", "10.123.6.0/24"]  # Intra subnets

  tags = {
    Example = local.name  # Using local variable inside tags
  }
}

provider "aws" {
    region = "us-east-1"  # Specifies AWS region
}
