resource "aws_ses_domain_identity" "ses_domain" {
  domain = "hemocione.com.br"
}

resource "aws_ses_domain_mail_from" "main" {
  domain           = aws_ses_domain_identity.ses_domain.domain
  mail_from_domain = "mail.${aws_ses_domain_identity.ses_domain.domain}"
}

resource "aws_ses_domain_dkim" "ses_domain_dkim" {
  domain = join("", aws_ses_domain_identity.ses_domain.*.domain)
}
