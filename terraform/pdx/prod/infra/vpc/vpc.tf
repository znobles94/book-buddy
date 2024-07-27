locals {
  default_tags = {
    Project     = "Book-Buddy"
    Environment = var.environment == "prod" ? "Production" : "Nonproduction"
  }
  tags = merge(local.default_tags, var.additional_tags)
}

data "aws_region" "current" {}

resource "aws_vpc" "default" {
  ipv4_ipam_pool_id   = aws_vpc_ipam_pool.ipam.id
  ipv4_netmask_length = 28
  depends_on = [
    aws_vpc_ipam_pool_cidr.ipam
  ]
  tags = local.tags
}

resource "aws_vpc_ipam" "ipam" {
  operating_regions {
    region_name = data.aws_region.current.name
  }
  tags = local.tags
}

resource "aws_vpc_ipam_pool" "ipam" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.ipam.private_default_scope_id
  locale         = data.aws_region.current.name
  tags           = local.tags
}

resource "aws_vpc_ipam_pool_cidr" "ipam" {
  ipam_pool_id = aws_vpc_ipam_pool.ipam.id
  cidr         = var.environment == "prod" ? "10.0.0.0/16" : "172.20.0.0/16"
}
