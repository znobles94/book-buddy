# data sources

data "aws_vpc" "default" {
  tags = {
    Environment = local.environment
    Project     = "Book-Buddy"
  }
}

data "aws_subnet" "default" {
  tags = {
    Environment = local.environment
    Project     = "Book-Buddy"
  }
}
