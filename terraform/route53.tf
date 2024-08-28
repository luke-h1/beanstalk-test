locals {
  api_name = var.env == "prod" ? "api" : "api-${var.env}"
}

resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = ["www.${var.domain_name}"]
}

data "aws_route53_zone" "zone" {
  name         = var.route_53_zone_name
  private_zone = false
}


resource "aws_route53_record" "record" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.zone.zone_id
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.record : record.fqdn]
}

resource "aws_route53_record" "lb" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "${local.api_name}.${var.domain_name}"
  type    = "CNAME"
  ttl     = 5
  records = [aws_elastic_beanstalk_environment.env.cname]
}