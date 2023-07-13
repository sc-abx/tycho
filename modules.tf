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
  # version = "1.0.1"
  version = "1.0.3-preview"

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


module "cloudwatch-agent" {
  source  = "app.terraform.io/AirboxSystems/cloudwatch-agent/aws"
  version = "1.0.5"

  providers = {
    kubernetes = kubernetes
  }
  environment_type = var.environment_type
  environment_name = var.environment_name
  environment_region = "eu-west-2"
}


module "pvc-monitoring" {
  source  = "app.terraform.io/AirboxSystems/pvc-monitoring/aws"
  version = "1.0.4"

  providers = {
    kubernetes = kubernetes
  }
  environment_type = var.environment_type
  environment_name = var.environment_name
  pvc_name = "ebs-mysql-pv-claim"
  pvc_attached_namespace = "databases"
  label_selector = "app=mysql"  
  email_subscription_endpoint = "shaun.carter@airboxsystems.com"

}
