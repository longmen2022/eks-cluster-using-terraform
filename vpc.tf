module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "~>4.0"  # Ensures compatibility with all 4.x versions

    name            = local.name  # Sets VPC name
    cidr            = local.vpc_cidr  # Defines VPC CIDR block
    azs             = local.azs  # Defines availability zones
    private_subnets = local.private_subnets  # Private subnet definitions
    public_subnets  = local.public_subnets  # Public subnet definitions
    intra_subnets   = local.intra_subnets  # Intra subnet definitions

    enable_nat_gateway = true  # Enables NAT gateway for private subnets

    public_subnet_tags = {
        "kubernetes.io/role/elb" = "1"  # Tag for external load balancer subnets
    }

    private_subnet_tags = {
        "kubernetes.io/role/internal-elb" = "1"  # Tag for internal load balancer subnets
    }
}
