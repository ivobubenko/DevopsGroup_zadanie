variable "private_cidr_blocks" {
  description = "CIDR block for the private subnet"
  type        = any
}

variable "vpc_id" {
  description = "Id of the main VPC"
  type        = string
}

variable "nat_id" {
  description = "Id of the nat gateway"
  type        = string
}

resource "aws_subnet" "private" {
  for_each = var.private_cidr_blocks

  vpc_id     = var.vpc_id
  cidr_block = each.value
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  route_table_id = aws_route_table.private.id
  subnet_id      = each.value.id
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  nat_gateway_id         = var.nat_id
  destination_cidr_block = "0.0.0.0/0"
}