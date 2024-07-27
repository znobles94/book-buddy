data "aws_region" "current" {}

resource "aws_vpc" "default" {
  /*
  ipv4_ipam_pool_id   = aws_vpc_ipam_pool.ipam.id
  ipv4_netmask_length = 16
  depends_on = [
    aws_vpc_ipam_pool_cidr.ipam
  ]
*/
  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"
  tags             = local.tags
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
  cidr         = local.cidr
}
