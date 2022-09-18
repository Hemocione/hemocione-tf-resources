locals {
  account = "401973936407"
  region  = "us-east-1"
  tags = {
    "hemocione:project"     = "infrastructre"
    "hemocione:squad"       = "tech"
    "hemocione:environment" = "default"
    "hemocione:iac"         = "data/infrastructure"
  }
}

provider "aws" {
  region = local.region
  allowed_account_ids = [
    local.account
  ]
  default_tags {
    tags = local.tags
  }
}

terraform {
  required_version = "~> 1.2"
  backend "s3" {
    bucket = "hemocione-iac"
    key    = "infrastructure"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30.0"
    }
  }
}
