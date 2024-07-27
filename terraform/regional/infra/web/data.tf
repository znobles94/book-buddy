# data sources

data "aws_vpc" "default" {
  tags = {
    Environment = local.environment
    Project     = "Book-Buddy"
  }
}

data "aws_subnets" "default" {
  tags = {
    Environment = local.environment
    Project     = "Book-Buddy"
    Role        = "Private-Subnet"
  }
}
