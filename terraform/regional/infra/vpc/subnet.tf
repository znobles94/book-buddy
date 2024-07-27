resource "aws_subnet" "default" {
  vpc_id     = aws_vpc.default.id
  cidr_block = local.under_cidr
  tags       = local.tags
}
