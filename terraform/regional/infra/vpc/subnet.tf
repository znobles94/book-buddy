resource "aws_subnet" "default" {
  count             = var.subnet_count
  availability_zone = var.availability_zones[count.index]
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.under_cidr[count.index] # start at beginning of cidr blocks
  tags              = merge(local.tags, { Role = "Private-Subnet" })
}

resource "aws_subnet" "public" {
  count                   = var.subnet_count
  availability_zone       = var.availability_zones[count.index]
  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.under_cidr[var.subnet_count + count.index] # start at second half of cidr blocks, under_cidr list should be twice length of the subnet_count number set
  map_public_ip_on_launch = true
  tags                    = merge(local.tags, { Role = "Public-Subnet" })

}
