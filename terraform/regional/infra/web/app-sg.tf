resource "aws_security_group" "app" {
  name        = "${var.environment}-App-Security-Group"
  description = "Allow HTTP/HTTPS traffic to App"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_app" {
  security_group_id = aws_security_group.app.id
  # open to all
  cidr_ipv4   = "0.0.0.0/32"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_app" {
  security_group_id = aws_security_group.app.id
  # open to all
  cidr_ipv4   = "0.0.0.0/32"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}
