module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "~>4.0"

    name            = local.name
    cidr            = local.vpc_cidr
    azs             = local.azs
    private_subnets = local.private_subnets
    public_subnets  = local.public_subnets
    intra_subnets   = local.intra_subnets

    enable_nat_gateway     = true  # Enables NAT gateway
    single_nat_gateway     = true  # Ensures only one NAT Gateway (optional)
    
    public_subnet_tags = {
        "kubernetes.io/role/elb" = "true"  # Uses string value
    }

    private_subnet_tags = {
        "kubernetes.io/role/internal-elb" = "true"  # Uses string value
    }
}
