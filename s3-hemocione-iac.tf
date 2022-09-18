resource "aws_s3_bucket" "hemocione-iac" {
  bucket = "hemocione-iac"
  tags = {
    Project                         = "infrastructre"
    Storage                         = "S3"
    "hemocione:data-classification" = "restrict"
  }

}

resource "aws_s3_bucket_acl" "hemocione-iac" {
  bucket = aws_s3_bucket.hemocione-iac.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "hemocione-iac" {
  bucket = aws_s3_bucket.hemocione-iac.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "hemocione-iac" {
  bucket = aws_s3_bucket.hemocione-iac.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "hemocione-iac" {
  bucket = aws_s3_bucket.hemocione-iac.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "hemocione-iac" {
  statement {
    sid = "S3ReadWrite"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = [
      aws_s3_bucket.hemocione-iac.arn,
      "${aws_s3_bucket.hemocione-iac.arn}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::401973936407:root",
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "hemocione-iac" {
  bucket = aws_s3_bucket.hemocione-iac.id
  policy = data.aws_iam_policy_document.hemocione-iac.json
}

output "hemocione-iac-arn" {
  value = aws_s3_bucket.hemocione-iac.arn
}