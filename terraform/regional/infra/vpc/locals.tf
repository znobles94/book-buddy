locals {
  cidr = var.environment == "prod" ? "10.0.0.0/16" : "172.16.0.0/16"
  # under_cidr = var.environment == "prod" ? "10.0.0.0/24" : "172.16.0.0/24"
  default_tags = {
    Project     = "Book-Buddy"
    Environment = var.environment == "prod" ? "Production" : "Nonproduction"
  }
  tags = merge(local.default_tags, var.additional_tags)
}
