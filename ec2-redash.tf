resource "aws_instance" "hemocione-redash" {
  ami           = "ami-0d915a031cabac0e0"
  instance_type = "t2.small"
  subnet_id     = aws_subnet.hemocione-subnet-ec2.id
  key_name      = aws_key_pair.hemocione-redash.key_name

  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.hemocione-sg.id
  ]

  tags = {
    Name = "hemocione-redash"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    tags = {
      Name = "hemocione-redash-ebs"
    }
  }
}

resource "aws_eip" "lb-redash" {
  instance = aws_instance.hemocione-redash.id
  vpc      = true
}

resource "aws_key_pair" "hemocione-redash" {
  key_name   = "hemocione-redash"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFbQOqppEiWuthxJSJz00XEA8YY3fzar8R4LJKbB5Ln3"
}
