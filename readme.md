# terraform-aws-vpc

A Terraform module for provisioning a production-ready AWS VPC with public, private, and database subnet tiers, NAT gateway, internet gateway, and route tables.

---

## Usage

```hcl
module "vpc" {
  source = "git::https://github.com/adepusaikumar/terraform-aws-vpc-module.git?ref=main"

  project     = "roboshop"
  environment = "dev"

  vpc_cidr = "10.0.0.0/16"

  public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs  = ["10.0.11.0/24", "10.0.12.0/24"]
  database_subnet_cidrs = ["10.0.21.0/24", "10.0.22.0/24"]

  is_peering_required = false
}
```

---

## Features

- VPC with configurable CIDR block and DNS hostname support
- Public, private, and database subnet tiers across multiple Availability Zones
- Internet Gateway for public subnets
- NAT Gateway (with Elastic IP) for private and database subnet outbound access
- Separate route tables for each subnet tier
- Optional VPC peering support flag
- Fully customizable tags on every resource

---


## Resources

| Name | Type |
|------|------|
| aws_vpc.main | resource |
| aws_internet_gateway.main | resource |
| aws_subnet.public | resource |
| aws_subnet.private | resource |
| aws_subnet.database | resource |
| aws_eip.nat | resource |
| aws_nat_gateway.main | resource |
| aws_route_table.public | resource |
| aws_route_table.private | resource |
| aws_route_table.database | resource |
| aws_route.public | resource |
| aws_route.private | resource |
| aws_route.database | resource |
| aws_route_table_association.public | resource |
| aws_route_table_association.private | resource |
| aws_route_table_association.database | resource |

---

## Inputs

| Name | Description | Type | Default | Required |
|---|-------------|------|---------|:--------:|
| project | Project name used for naming and tagging resources | `string` | n/a | yes |
| environment | Deployment environment. Must be one of: `dev`, `qa`, `uat`, `prod` | `string` | n/a | yes |
| vpc_cidr | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| public_subnet_cidrs | List of CIDR blocks for public subnets. One subnet is created per AZ. | `list(string)` | `["10.0.1.0/24", "10.0.2.0/24"]` | no |
| private_subnet_cidrs | List of CIDR blocks for private subnets. One subnet is created per AZ. | `list(string)` | `["10.0.11.0/24", "10.0.12.0/24"]` | no |
| database_subnet_cidrs | List of CIDR blocks for database subnets. One subnet is created per AZ. | `list(string)` | `["10.0.21.0/24", "10.0.22.0/24"]` | no |
| vpc_tags | Additional tags to merge on the VPC resource | `map(string)` | `{}` | no |
| igw_tags | Additional tags to merge on the Internet Gateway | `map(string)` | `{}` | no |
| public_subnet_tags | Additional tags to merge on public subnets | `map(string)` | `{}` | no |
| private_subnet_tags | Additional tags to merge on private subnets | `map(string)` | `{}` | no |
| database_subnet_tags | Additional tags to merge on database subnets | `map(string)` | `{}` | no |
| public_route_table_tags | Additional tags to merge on the public route table | `map(string)` | `{}` | no |
| private_route_table_tags | Additional tags to merge on the private route table | `map(string)` | `{}` | no |
| database_route_table_tags | Additional tags to merge on the database route table | `map(string)` | `{}` | no |
| eip_tags | Additional tags to merge on the Elastic IP | `map(string)` | `{}` | no |
| nat_gateway_tags | Additional tags to merge on the NAT Gateway | `map(string)` | `{}` | no |
| is_peering_required | Whether VPC peering is required. Enables peering-related resources when set to `true`. | `bool` | `false` | no |

---

## Outputs

> Outputs should be defined in your `outputs.tf`. Common outputs from this module include:

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| public_subnet_ids | List of public subnet IDs |
| private_subnet_ids | List of private subnet IDs |
| database_subnet_ids | List of database subnet IDs |

---

## Subnet Naming Convention

Resources are named following this pattern:

```
{project}-{environment}-{tier}-{availability-zone}
```

**Example:**

```
roboshop-dev-public-us-east-1a
roboshop-dev-private-us-east-1b
roboshop-dev-database-us-east-1a
```

---

## Architecture

![alt text](vpc-module.jpg)

---

## License

MIT