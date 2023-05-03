variable "environment_name" {
  type    = string
  default = "tycho"
}

variable "environment_type" {
  type    = string
  default = "Development"
}


variable "loadbalancer_domain_name" {
  description = "Optionally specify the domain for the loadbalancer, otherwise <<env>>.airboxsystems.com will be used"
  type        = string
  default     = null
}

variable "dev_access_to_DB" {
  type    = bool
  default = true
}
