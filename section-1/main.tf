provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.main.id
}

module "public_subnets" {
  source            = "./modules/public_subnet"
  igw_id            = aws_internet_gateway.internet.id
  vpc_id            = aws_vpc.main.id
  public_cidr_block = var.public_cidr_block
}

module "private_subnets" {
  source              = "./modules/private_subnet"
  vpc_id              = aws_vpc.main.id
  nat_id              = module.public_subnets.nat_gateway_id
  private_cidr_blocks = var.private_cidr_blocks
}