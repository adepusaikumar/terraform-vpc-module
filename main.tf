resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    tags = var.vpc_final_tags
}