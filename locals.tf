locals {
  name = lower("tf-${var.environment_type}-${var.environment_name}")

  # mssql_db_password = jsondecode(data.aws_secretsmanager_secret_version.tycho_mssql_db.secret_string)["password"]

  # mssql_db_username = jsondecode(data.aws_secretsmanager_secret_version.tycho_mssql_db.secret_string)["username"]

  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMvKmR04tuFmSqbymT2VbqEWEI5P4zDqiiLz9ICuJ+Z1lC+CNx1K2IcqEZhnWYjBgiZKWE1PCcFE5uUmtp8NsoQIsrpS34VwCl/gX+j5kM6/cZcYjdOiLxowFTdWBKAPaQ690OgrGdUxmgh26LkvJN6Hh/S89BBlGwJYPRcWrfV+6DAiSKPWjTnY9nttr/yrudB74hfoxMmp8ApaPcqbNhJI9LoX2k9sEhVZSjb4kPwddUmhv/sSwDbpnlePuWpZMZJ4uDuciz5sWsllG75Gcl+JrTUx50c7BsAvvkG/aF1ltdVX30PDKzG/Ej0493sT3WtMHl+XNbqT2DTL4YqPTRYN86LhTPALTeQnnhdJgh1hwvDVOowAOlm7dKhGUGKfoQUTTXLyr+Em0xzIwHCGVcfwwsLo4P3vKWp03In6iGWZUyyVmw7ui+W042lvXGJkY2vkqF9sT7BwbA8xc6YShLN8H6IUrOj9Nnd5bP8d4oUzyoB9GOauqrFUelPn+jyV0= pub@tycho"

  # red_sns_topics = [
  #   "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:Server-Alarm",
  #   "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:tf-red-alarm"
  # ]

  # amber_sns_topics = [
  #   "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:Server-Alarm",
  #   "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:tf-amber-alarm"
  # ]

  # green_sns_topics = [
  #   "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:Server-Alarm",
  #   "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:tf-green-alarm"
  # ]

  # route53_alarm_sns_topics = [
  #   "arn:aws:sns:us-east-1:${data.aws_caller_identity.current.account_id}:Server-Alarm",
  #   "arn:aws:sns:us-east-1:${data.aws_caller_identity.current.account_id}:tf-red-alarm"
  # ]

  remote_admin_cidr_blocks = [
    "81.149.155.129/32",
    "18.134.34.138/32",
    "18.130.142.46/32",
    "18.168.99.135/32"
  ]

  # tc_admin_cidr_blocks = [
  #   "81.149.155.129/32",
  #   "18.134.34.138/32",
  #   "18.130.142.46/32",
  #   "18.168.99.135/32"
  # ]

  admin_cidr_blocks = [
    "81.149.155.129/32",
    "18.134.34.138/32",
    "18.130.142.46/32",
    "18.168.99.135/32"
  ]

  default_tags = {
    EnvironmentType = var.environment_type
    Environment     = var.environment_name
  }

  eks_node_groups = {
    m5-2xlarge = {
      disk_size        = 50
      instance_type    = "m5.2xlarge"
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
    }
  }

  map_users = {
    masters = [
      "shaun.carter",
    ]
    developers = []
  }

  map_roles = {
    roles = [
      "arn:aws:iam::304333971729:role/AWSReservedSSO_AWSReadOnlyAccess_a4d134aff32abe23",
      "arn:aws:iam::304333971729:role/AWSReservedSSO_AWSPowerUserAccess_daef52d4328d91ee",
      "arn:aws:iam::304333971729:role/AWSReservedSSO_AWSAdministratorAccess_15917e8fc9a457be"
    ]
  }

  #public_eu_west_2c = "subnet-014d79c0106c1b6d4"

}