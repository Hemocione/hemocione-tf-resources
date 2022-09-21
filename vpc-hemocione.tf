resource "aws_vpc" "hemocione-vpc" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "hemocione-vpc"
  }
}

resource "aws_subnet" "hemocione-subnet-rds-a" {
  vpc_id            = aws_vpc.hemocione-vpc.id
  cidr_block        = "172.31.96.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "hemocione-subnet-rds-a"
  }
}

resource "aws_subnet" "hemocione-subnet-rds-b" {
  vpc_id            = aws_vpc.hemocione-vpc.id
  cidr_block        = "172.31.97.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "hemocione-subnet-rds-b"
  }
}

resource "aws_subnet" "hemocione-subnet-rds-c" {
  vpc_id            = aws_vpc.hemocione-vpc.id
  cidr_block        = "172.31.98.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "hemocione-subnet-rds-c"
  }
}

resource "aws_subnet" "hemocione-subnet-rds-d" {
  vpc_id            = aws_vpc.hemocione-vpc.id
  cidr_block        = "172.31.99.0/24"
  availability_zone = "us-east-1d"
  tags = {
    Name = "hemocione-subnet-rds-d"
  }
}

resource "aws_subnet" "hemocione-subnet-rds-e" {
  vpc_id            = aws_vpc.hemocione-vpc.id
  cidr_block        = "172.31.100.0/24"
  availability_zone = "us-east-1e"
  tags = {
    Name = "hemocione-subnet-rds-e"
  }
}

resource "aws_subnet" "hemocione-subnet-rds-f" {
  vpc_id            = aws_vpc.hemocione-vpc.id
  cidr_block        = "172.31.101.0/24"
  availability_zone = "us-east-1f"
  tags = {
    Name = "hemocione-subnet-rds-f"
  }
}

resource "aws_network_acl" "hemocione-acl" {
  vpc_id = aws_vpc.hemocione-vpc.id
  subnet_ids = [
    aws_subnet.hemocione-subnet-rds-a.id,
    aws_subnet.hemocione-subnet-rds-b.id,
    aws_subnet.hemocione-subnet-rds-c.id,
    aws_subnet.hemocione-subnet-rds-d.id,
    aws_subnet.hemocione-subnet-rds-e.id,
    aws_subnet.hemocione-subnet-rds-f.id
  ]

  egress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "hemocione-acl"
  }
}

resource "aws_network_acl_association" "hemocione-acl-assoc-rds-a" {
  network_acl_id = aws_network_acl.hemocione-acl.id
  subnet_id      = aws_subnet.hemocione-subnet-rds-a.id
}

resource "aws_network_acl_association" "hemocione-acl-assoc-rds-b" {
  network_acl_id = aws_network_acl.hemocione-acl.id
  subnet_id      = aws_subnet.hemocione-subnet-rds-b.id
}

resource "aws_network_acl_association" "hemocione-acl-assoc-rds-c" {
  network_acl_id = aws_network_acl.hemocione-acl.id
  subnet_id      = aws_subnet.hemocione-subnet-rds-c.id
}

resource "aws_network_acl_association" "hemocione-acl-assoc-rds-d" {
  network_acl_id = aws_network_acl.hemocione-acl.id
  subnet_id      = aws_subnet.hemocione-subnet-rds-d.id
}

resource "aws_network_acl_association" "hemocione-acl-assoc-rds-e" {
  network_acl_id = aws_network_acl.hemocione-acl.id
  subnet_id      = aws_subnet.hemocione-subnet-rds-e.id
}

resource "aws_network_acl_association" "hemocione-acl-assoc-rds-f" {
  network_acl_id = aws_network_acl.hemocione-acl.id
  subnet_id      = aws_subnet.hemocione-subnet-rds-f.id
}

resource "aws_internet_gateway" "hemocione-igw" {
  vpc_id = aws_vpc.hemocione-vpc.id
  tags = {
    Name = "hemocione-igw"
  }
}

resource "aws_route_table" "hemocione-rtb-rds" {
  vpc_id = aws_vpc.hemocione-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hemocione-igw.id
  }
  tags = {
    Name = "hemocione-rtb-rds"
  }
}

resource "aws_route_table_association" "hemocione-rtb-assoc-rds-a" {
  subnet_id      = aws_subnet.hemocione-subnet-rds-a.id
  route_table_id = aws_route_table.hemocione-rtb-rds.id
}

resource "aws_route_table_association" "hemocione-rtb-assoc-rds-b" {
  subnet_id      = aws_subnet.hemocione-subnet-rds-b.id
  route_table_id = aws_route_table.hemocione-rtb-rds.id
}

resource "aws_route_table_association" "hemocione-rtb-assoc-rds-c" {
  subnet_id      = aws_subnet.hemocione-subnet-rds-c.id
  route_table_id = aws_route_table.hemocione-rtb-rds.id
}

resource "aws_route_table_association" "hemocione-rtb-assoc-rds-d" {
  subnet_id      = aws_subnet.hemocione-subnet-rds-d.id
  route_table_id = aws_route_table.hemocione-rtb-rds.id
}

resource "aws_route_table_association" "hemocione-rtb-assoc-rds-e" {
  subnet_id      = aws_subnet.hemocione-subnet-rds-e.id
  route_table_id = aws_route_table.hemocione-rtb-rds.id
}

resource "aws_route_table_association" "hemocione-rtb-assoc-rds-f" {
  subnet_id      = aws_subnet.hemocione-subnet-rds-f.id
  route_table_id = aws_route_table.hemocione-rtb-rds.id
}

resource "aws_security_group" "hemocione-sg" {
  name        = "hemocione-sg"
  description = "Allow All Traffic"
  vpc_id      = aws_vpc.hemocione-vpc.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "hemocione-sg"
  }
}