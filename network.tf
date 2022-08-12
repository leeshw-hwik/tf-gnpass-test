resource "aws_internet_gateway" "gnpass-prod-igw" {
  vpc_id = aws_vpc.gnpass-vpc.id
  tags = {
    Name = "gnpass-prod-igw"
  }
}

resource "aws_route_table" "gnpass-prod-public-crt" {
  vpc_id = aws_vpc.gnpass-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gnpass-prod-igw.id
  }

  tags = {
    Name = "gnpass-prod-public-crt"
  }
}

resource "aws_route_table_association" "gnpass-prod-crta-public-subnet-1" {
  subnet_id      = aws_subnet.gnpass-subnet-public-1.id
  route_table_id = aws_route_table.gnpass-prod-public-crt.id
}

resource "aws_security_group" "allow-ssh" {
  vpc_id = aws_vpc.gnpass-vpc.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    # description      = "value"
    from_port = 0
    # ipv6_cidr_blocks = ["::/0"]
    # prefix_list_ids  = ["value"]
    protocol = "-1"
    # security_groups  = ["value"]
    # self    = false
    to_port = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow ssh"
    from_port   = 22
    # ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids = [aws_ec2_managed_prefix_list.ap-northeast-2-vpc-networks.id]
    protocol        = "tcp"
    # security_groups  = ["value"]
    # self             = false
    to_port = 22
  }

  tags = {
    Name = "allow ssh"
  }
}

resource "aws_security_group" "allow-http" {
  vpc_id = aws_vpc.gnpass-vpc.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    # description      = "value"
    from_port = 0
    # ipv6_cidr_blocks = ["::/0"]
    # prefix_list_ids  = ["value"]
    protocol = "-1"
    # security_groups  = ["value"]
    # self    = false
    to_port = 0
  }

  ingress {
    # cidr_blocks = ["0.0.0.0/0"]
    description = "allow http"
    from_port   = 80
    # ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids = [aws_ec2_managed_prefix_list.any-source-ip.id]
    protocol        = 6
    # security_groups  = ["value"]
    # self             = false
    to_port = 80
  }

  tags = {
    Name = "allow http"
  }
}
