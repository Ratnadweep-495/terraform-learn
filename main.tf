provider "aws" {
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"
  default = "10.0.20.0/24"
  type = string
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
  type = list(string)
}
resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_cidr_block[0]
  tags = {
    Name: "development"
    Ratnadweep: "Ghosh"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "us-east-2a"
  tags = {
    Name: "subnet-1-dev"
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}
resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "us-east-2a"
  tags = {
    Name: "subnet-2-existing"
  }
}

output "dev-subnet-2_id" {
  value = aws_subnet.dev-subnet-2.id
}

output "dev-subnet-2_availability_zone_id" {
  value = aws_subnet.dev-subnet-2.availability_zone_id
}