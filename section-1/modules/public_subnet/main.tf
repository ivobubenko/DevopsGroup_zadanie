variable "public_cidr_block" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "vpc_id" {
  description = "Id of the main VPC"
  type        = string
}

variable "igw_id" {
  description = "Internet gateway id"
  type        = string
}

resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_cidr_block
  map_public_ip_on_launch = true
  tags                    = { Name = "public" }
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
}

resource "aws_route" "internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "public" {
  domain = "vpc"
}

resource "aws_nat_gateway" "public" {
  subnet_id     = aws_subnet.public.id
  allocation_id = aws_eip.public.id
}

