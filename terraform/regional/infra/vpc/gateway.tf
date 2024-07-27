resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.default.id
  tags   = merge(local.tags, { Role = "IGW" })
}

resource "aws_eip" "nat" {
  count  = var.subnet_count
  domain = "vpc"
  tags   = merge(local.tags, { Role = "NAT" })
}

resource "aws_nat_gateway" "nat" {
  count         = var.subnet_count
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags          = merge(local.tags, { Role = "NAT" })
  depends_on    = [aws_internet_gateway.gateway]
}
