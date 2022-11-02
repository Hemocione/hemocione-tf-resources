resource "aws_iam_user" "smtp-hemocione-user" {
  name = "no-reply-ses"
}

resource "aws_iam_access_key" "smtp-hemocione-user" {
  user = aws_iam_user.smtp-hemocione-user.name
}

data "aws_iam_policy_document" "ses-sender-policy-document" {
  statement {
    sid = "SendEmail"
    actions   = [
        "ses:SendRawEmail"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ses-sender-policy" {
  name        = "ses-sender-policy"
  description = "Allows sending of e-mails via Simple Email Service"
  policy      = data.aws_iam_policy_document.ses-sender-policy-document.json
}

resource "aws_iam_user_policy_attachment" "ses-attach-policy" {
  user       = aws_iam_user.smtp-hemocione-user.name
  policy_arn = aws_iam_policy.ses-sender-policy.arn
}

output "smtp-hemocione-username" {
  value = aws_iam_access_key.smtp-hemocione-user.id
}

output "smtp-hemocione-password" {
  value = aws_iam_access_key.smtp-hemocione-user.ses_smtp_password_v4
  sensitive = true
}