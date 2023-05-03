terraform {
  required_version = "v0.14.8"

  backend "s3" {
    bucket  = "awsplatform.terraform-state"
    key     = "tycho-terraform.tfstate"
    region  = "eu-west-2"
    profile = "awsplatform"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = "awsplatform"
  region  = "eu-west-2"
}

provider "aws" {
  alias   = "east"
  region  = "us-east-1"
  profile = "awsplatform"
}

provider "aws" {
  alias   = "kubernetes"
  region  = "eu-west-2"
  profile = "awsplatform"

  ignore_tags {
    key_prefixes = ["kubernetes.io/"]
  }
}

provider "kubernetes" {
  host                   = module.eks_cluster.provider_config.host
  cluster_ca_certificate = module.eks_cluster.provider_config.cluster_ca_certificate
  token                  = module.eks_cluster.provider_config.token
}

# provider "helm" {
#   kubernetes {
#     host                   = module.eks_cluster.provider_config.host
#     cluster_ca_certificate = module.eks_cluster.provider_config.cluster_ca_certificate
#     token                  = module.eks_cluster.provider_config.token
#   }
# }
