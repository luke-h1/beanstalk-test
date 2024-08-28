variable "app_name" {
  type    = string
  default = "beanstalk-poc"
}

variable "env" {
  type        = string
  default     = "dev"
  description = "The environment to deploy to"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-0887a361af334c37c"
  description = "The VPC to create resources within"
}

variable "instance_type" {
  type        = string
  description = "The compute instance to use"
  default     = "t2.small"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "The public subnets to apply"
}

variable "container_port" {
  type        = number
  default     = 8000
  description = "The port that the service listens on"
}
variable "domain_name" {
  type        = string
  default     = "beanstalk-poc.lhowsam.com"
  description = "The domain name to use"
}

variable "route_53_zone_name" {
  type        = string
  default     = "lhowsam.com"
  description = "the route 53 zone to use"
}

variable "private_key" {
  type        = string
  description = "private key"
}
variable "certificate_body" {
  type        = string
  description = "cert body"
}
variable "certificate_chain" {
  type        = string
  description = "certificate_chain"
}

