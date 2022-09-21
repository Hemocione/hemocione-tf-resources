resource "aws_db_instance" "hemocione-rds" {
  db_name           = "hemocione"
  engine            = "postgresql"
  engine_version    = "14.4"
  instance_class    = "db.t2.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  vpc_security_group_ids = [
    aws_security_group.hemocione-sg.id
  ]
  db_subnet_group_name = "hemocione-rds"
  parameter_group_name = "default.postgres14"

  username          = "foo"
  password          = "foobarbaz"
  port              = "5432"
  multi_az          = false
  storage_encrypted = false
}