

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = "${var.tfname}-eks-vpc"
  cidr = "10.0.0.0/16"

  azs                     = ["us-east-1a", "us-east-1b"]
  public_subnets          = ["10.0.2.0/24", "10.0.3.0/24"]
  map_public_ip_on_launch = true

  enable_nat_gateway = false
  #single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  public_subnet_tags = {
    "kubernetes.io/role/els" = 1
  }

}
