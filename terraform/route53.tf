resource "aws_acm_certificate" "root_domain" {
  provider          = aws.us-east-1
  domain_name       = var.domain_name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true

    # only set to false because we might need to do a full teardown
    prevent_destroy = false
  }
}


# create an entry in route53 for the load balancer and the given domain
resource "aws_acm_certificate" "cert" {
  private_key       = var.private_key
  certificate_body  = var.certificate_body
  certificate_chain = var.certificate_chain
  tags = {
    Name    = "certificate for ${var.env}"
    stage   = var.env
    service = "pets-api"
  }
}
data "aws_route53_zone" "domain" {
  name         = var.route_53_zone_name
  private_zone = false
}


resource "aws_route53_record" "lb" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = var.domain_name
  type    = "CNAME"
  ttl     = 60
  records = [aws_elastic_beanstalk_environment.env.cname]
}