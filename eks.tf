module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = "grupo14-eks-cluster"
  cluster_version = "1.32"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    grupo14-ng = {
      ami = data.aws_ami.ubuntu.id
      instance_types = ["t2.micro"]
    }
  }

}