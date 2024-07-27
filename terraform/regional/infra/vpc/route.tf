resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block           = aws_vpc.default.cidr_block
    network_interface_id = aws_network_interface.default.id
  }
}

resource "aws_network_interface" "default" {
  subnet_id = aws_subnet.default.id
}

// todo ; gateways, external -> ALB routes
