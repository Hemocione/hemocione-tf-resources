resource "aws_s3_bucket" "hemocione-assets" {
  bucket = "hemocione-assets"
  tags = {
    Project                         = "infrastructre"
    Storage                         = "S3"
    "hemocione:data-classification" = "public"
  }

}

resource "aws_s3_bucket_acl" "hemocione-assets" {
  bucket = aws_s3_bucket.hemocione-assets.id
  acl    = "public-read"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "hemocione-assets" {
  bucket = aws_s3_bucket.hemocione-assets.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "hemocione-assets" {
  bucket = aws_s3_bucket.hemocione-assets.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

data "aws_iam_policy_document" "hemocione-assets" {
  statement {
    sid = "S3Write"
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      aws_s3_bucket.hemocione-assets.arn,
      "${aws_s3_bucket.hemocione-assets.arn}/*",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::401973936407:root",
      ]
    }
  }

  statement {
    sid = "S3ReadAll"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]

    resources = [
      "${aws_s3_bucket.hemocione-assets.arn}/*",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "*",
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "hemocione-assets" {
  bucket = aws_s3_bucket.hemocione-assets.id
  policy = data.aws_iam_policy_document.hemocione-assets.json
}

output "hemocione-assets-arn" {
  value = aws_s3_bucket.hemocione-assets.arn
}
