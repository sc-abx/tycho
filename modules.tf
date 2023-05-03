module "vpc" {
  source  = "app.terraform.io/AirboxSystems/vpc/aws"
  version = "1.0.2"

  environment_name = var.environment_name
  environment_type = var.environment_type

  providers = {
    aws = aws.kubernetes
  }
}

module "eks_cluster" {
  source  = "app.terraform.io/AirboxSystems/eks/aws"
  version = "1.0.1"

  providers = {
    kubernetes = kubernetes
    # helm       = helm
  }

  environment_type = var.environment_type
  environment_name = var.environment_name
  tags             = local.default_tags

  subnets = {
    public  = module.vpc.public_subnets
    private = []
  }

  map_users = local.map_users
  sso_roles = local.map_roles

  node_groups = local.eks_node_groups

  #route53_zone_id = "Z3CI00RWAP367L"
}

# module "cloudwatch-agent" {
#   source  = "bailey84j/cloudwatch-agent/kubernetes"
#   version = "1.0.1"
#   create_namespace = true
#   eks_cluster_name = "tf-development-tycho"

#   # insert the 4 required variables here
# }