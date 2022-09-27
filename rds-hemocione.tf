data "aws_kms_secrets" "hemocione-rds" {
  /*
  aws kms encrypt --key-id 52efff29-8ba9-48c8-b24f-a01467889aed  --plaintext 'demo' --encryption-context foo=bar --output text --query CiphertextBlob
  */

  secret {
    name    = "master_username"
    payload = "AQICAHgVoJjFrbxAy/iwMOATko3Vnwc/oO9hehoMi8rYyVzXjQEcU+OrImvEXnxHVgLz6PT/AAAAajBoBgkqhkiG9w0BBwagWzBZAgEAMFQGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMFzUpj1KfPC+OZMY9AgEQgCeoe/36tRUmNF8ycxhyUt6UHySTWuPNKNhgyC5+nRge3LClITmf93w="

    context = {
      postgres = "username"
    }
  }

  secret {
    name    = "master_password"
    payload = "AQICAHgVoJjFrbxAy/iwMOATko3Vnwc/oO9hehoMi8rYyVzXjQHs8/tdGh6/Mz59YqLjyj2qAAAAejB4BgkqhkiG9w0BBwagazBpAgEAMGQGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMdLms3BOy0CDf6PKUAgEQgDeFZrNj2w+7MpeSbNoiIv1hVQwmooGqVLCM3jXjTdP6GfSZtTwg+j16L8OL2Vha1487NkF0/+T4"
    context = {
      postgres = "password"
    }
  }
}

resource "aws_db_instance" "hemocione-rds" {
  db_name           = "hemocione"
  identifier        = "hemocione"
  engine            = "postgres"
  engine_version    = "12.11"
  instance_class    = "db.t2.micro"
  allocated_storage = 20
  storage_type      = "gp2"
  publicly_accessible = true
  vpc_security_group_ids = [
    aws_security_group.hemocione-sg.id
  ]

  db_subnet_group_name = aws_db_subnet_group.hemocione-subnetgroup-rds.name
  parameter_group_name = "default.postgres12"

  username          = data.aws_kms_secrets.hemocione-rds.plaintext["master_username"]
  password          = data.aws_kms_secrets.hemocione-rds.plaintext["master_password"]
  port              = "5432"
  multi_az          = false
  storage_encrypted = false
}
