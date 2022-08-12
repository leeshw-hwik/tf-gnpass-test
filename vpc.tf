resource "aws_vpc" "gnpass-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"

  tags = {
    Name = "gnpass-prod-vpc"
  }
}

resource "aws_subnet" "gnpass-subnet-public-1" {
  vpc_id                  = aws_vpc.gnpass-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "gnpass-subnet-public-1"
  }
}
