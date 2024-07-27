resource "aws_security_group" "lb" {
  name        = "${var.environment}-ALB-Security-Group"
  description = "Allow HTTP/HTTPS traffic to ALB"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_lb" {
  security_group_id = aws_security_group.lb.id
  # open to all
  cidr_ipv4   = "0.0.0.0/32"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_lb" {
  security_group_id = aws_security_group.lb.id
  # open to all
  cidr_ipv4   = "0.0.0.0/32"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}
