variable "additional_tags" {
  type        = map(string)
  description = "Additional tags for the VPC resources"
  default     = {}
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b"]
}

variable "environment" {
  type        = string
  default     = "Nonproduction"
  description = "Environment that VPC / subnet / routing resources will be built for"
}

variable "subnet_count" {
  type        = number
  default     = 2
  description = "Number of subnets to create"
}

variable "under_cidr" {
  type    = list(string)
  default = ["172.16.0.0/24", "172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
}
