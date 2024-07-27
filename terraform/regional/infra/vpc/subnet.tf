resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.default.id
  cidr_block = local.cidr
}
