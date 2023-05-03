# resource "aws_key_pair" "server_key_pair" {
#   key_name   = "${var.environment_name}-server-key"
#   public_key = local.ssh_public_key
# }

resource "aws_security_group" "loadbalancer" {
  name        = "loadbalancer"
  description = "Allow Traffic for Load Balancer"
  vpc_id      = module.vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Zuul"
    from_port   = 9999
    to_port     = 10000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = ""
    from_port   = 52583
    to_port     = 53561
    protocol    = "tcp"
    cidr_blocks = [
      "18.130.142.46/32",
      "81.149.155.129/32"
    ]
  }

  egress {
    description = "All Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${local.name}-loadbalancer"
    },
    local.default_tags
  )
}

resource "aws_security_group" "postgres" {
  name        = "${local.name}-postgres"
  description = "Allow postgres traffic"
  vpc_id      = module.vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [module.vpc.cidr_block]
    description = "Allow postgres traffic"
  }


  tags = merge(
    {
      Name = "${local.name}-postgres"
    },
    local.default_tags
  )
}
