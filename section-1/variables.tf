variable "private_cidr_blocks" {
  description = "Ip range for the given subnet"
  default     = { database : "10.0.1.0/24", server : "10.0.2.0/24" }
  type        = map(string)
}

variable "public_cidr_block" {
  description = "Ip range for the given subnet"
  default     = "10.0.3.0/24"
  type        = string
}
variable "aws_region" {
  description = "AWS region"
  default     = "eu-north-1"
  type        = string
}