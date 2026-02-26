# Task A

## Main module
- contains common resources
- creates private and public subnet modules using variables
- creates VPC and IGW and sends its ID to the submodules

## Public subnet
- creates subnet for the resources that can be available to the internet
- routes traffic to internet using igw
- contains NAT gateway for the private subnets allowing only outbound connections
- route table contains 0.0.0.0/0 -> IGW
- 10.0.3.0/24

## Private subnet
- creates subnets for the resources that cannot be available to the internet
- allows resources in it to communicate with internet using outbound connections
- 10.0.1.0/24 and 10.0.2.0/24
- 0.0.0.0/0 -> NAT

## Commands
$ terraform init
$ terraform plan
$ terraform apply