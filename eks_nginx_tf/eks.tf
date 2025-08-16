module "eks" {
  source  = "terraform-aws-modules/eks/aws"
 # version = "~> 20.0"

  cluster_name    = "${var.tfname}-eks-cluster"
  cluster_version = "1.31"

  bootstrap_self_managed_addons = true
  cluster_addons = {
    kube-proxy = {
      addon_version     = "v1.31.0-eksbuild.5"
      resolve_conflicts = "PRESERVE"
    }
    vpc-cni = {
      addon_version     = "v1.18.3-eksbuild.3"
      resolve_conflicts = "PRESERVE"
    }
    coredns = {
      addon_version     = "v1.11.3-eksbuild.1"
      resolve_conflicts = "PRESERVE"
    }
  }

  enable_irsa = true

  # Optional
  cluster_endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.public_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t2.micro"]
    //  remote_access = {
    //    ec2_ssh_key               = "eks-key-tf"
    //    source_security_group_ids = ["sg-06ae4ea6dae4dd4d8"]
    //  }

  }

  eks_managed_node_groups = {
    "${var.tfname}-eks-ng" = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t2.medium"]

      min_size      = 1
      max_size      = 2
      desired_size  = 1
      capacity_type = "ON_DEMAND"
      key_name      = "eks-key-tf"
      // use_custom_launch_template = false
      // remote_access = {
      //   ec2_ssh_key = "eks-key-tf"
      //source_security_group_ids = ["sg-06ae4ea6dae4dd4d8"]
      // }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

