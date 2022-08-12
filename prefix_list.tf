resource "aws_ec2_managed_prefix_list" "ap-northeast-2-vpc-networks" {
  name           = "All VPC CIDR-s"
  address_family = "IPv4"
  max_entries    = 5

  entry {
    cidr        = aws_vpc.gnpass-vpc.cidr_block
    description = "Primary"
  }
}

resource "aws_ec2_managed_prefix_list" "any-source-ip" {
  name           = "Any Request"
  address_family = "IPv4"
  max_entries    = 5

  entry {
    cidr        = "0.0.0.0/0"
    description = "Any Request"
  }
}
