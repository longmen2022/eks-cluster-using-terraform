module "eks" {
    source  = "terraform-aws-modules/eks/aws"  # Specifies the module source from Terraform Registry
    version = "19.15.1"  # Defines the version of the EKS module to use

    cluster_name                     = local.name  # Sets the name of the EKS cluster
    cluster_endpoint_public_access   = true  # Allows public access to the cluster endpoint

    cluster_addons = {  # Configures additional components for the EKS cluster
        coredns = { most_recent = true }  # Ensures CoreDNS is always using the latest version
        kube-proxy = { most_recent = true }  # Ensures kube-proxy is up to date
        vpc-cni = { most_recent = true }  # Uses the latest version of the VPC CNI plugin for networking
    }

    vpc_id                     = module.vpc.vpc_id  # Links the cluster to the VPC
    subnet_ids                 = module.vpc.private_subnets  # Associates the cluster with private subnets
    control_plane_subnet_ids   = module.vpc.intra_subnets  # Specifies subnets for the control plane

    eks_managed_node_group_defaults = {  # Sets default configurations for EKS managed node groups
        ami_type                               = "AL2_x86_64"  # Specifies Amazon Linux 2 as the AMI type
        instance_types                         = ["m5.large"]  # Uses `m5.large` EC2 instances for worker nodes
        attach_cluster_primary_security_group  = true  # Attaches the primary security group to node groups
    }

    eks_managed_node_groups = {  # Defines the managed node groups within the EKS cluster
        longmen-cluster-wg = {
            min_size       = 1  # Minimum number of nodes in the group
            max_size       = 2  # Maximum number of nodes in the group
            desired_size   = 1  # Desired number of nodes during deployment

            instance_types = ["t3.large"]  # Specifies the instance type for the node group
            capacity_type  = "SPOT"  # Uses Spot instances to optimize cost

            tags = {
                ExtraTag = "Hello World"  # Adds an example tag to the node group
            }
        }
    }

    tags = local.tags  # Assigns general tags to the EKS cluster
}
