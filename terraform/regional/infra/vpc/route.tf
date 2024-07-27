resource "aws_route_table" "default" {
  count  = var.subnet_count
  vpc_id = aws_vpc.default.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }
  tags = merge(local.tags, { Role = "NAT" })
}

resource "aws_route_table" "public" {
  count  = var.subnet_count
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = merge(local.tags, { Role = "IGW" })
}

resource "aws_route_table_association" "default" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.default[count.index].id
  route_table_id = aws_route_table.default[count.index].id
}

resource "aws_route_table_association" "private" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

/*
resource "aws_network_interface" "default" {
  count     = var.subnet_count
  subnet_id = aws_subnet.default[count.index].id
}
*/
// todo ; gateways, external -> ALB routes
