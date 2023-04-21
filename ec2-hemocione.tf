resource "aws_instance" "hemocione-caprover" {
  ami           = "ami-0ee23bfc74a881de5"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.hemocione-subnet-ec2.id
  key_name      = aws_key_pair.hemocione-caprover.key_name

  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.hemocione-sg.id
  ]

  tags = {
    Name = "hemocione-caprover"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 32
    tags = {
      Name = "hemocione-caprover-ebs"
    }
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.hemocione-caprover.id
  vpc      = true
}

resource "aws_subnet" "hemocione-subnet-ec2" {
  vpc_id            = aws_vpc.hemocione-vpc.id
  cidr_block        = "172.31.102.0/24"
  availability_zone = "us-east-1d"
  tags = {
    Name = "hemocione-subnet-ec2"
  }
}

resource "aws_route_table_association" "hemocione-rtb-assoc-ec2" {
  subnet_id      = aws_subnet.hemocione-subnet-ec2.id
  route_table_id = aws_route_table.hemocione-rtb-rds.id
}

resource "aws_key_pair" "hemocione-caprover" {
  key_name   = "hemocione-caprover"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFbQOqppEiWuthxJSJz00XEA8YY3fzar8R4LJKbB5Ln3"
}

data "aws_ami" "ubuntu18" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]

}
