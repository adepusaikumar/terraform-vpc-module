resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    tags = local.vpc_final_tags
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = local.igw_final_tags
}


# Public Subnets
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  count = length(var.public_subnet_cidrs)
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  tags = merge(
    local.common_tags,
    {
      # roboshop-dev-public-
      Name = "${var.project}-public-${var.environment}"
    },
    var.public_subnet_tags
  )
}