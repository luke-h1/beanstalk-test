

resource "aws_elastic_beanstalk_application" "app" {
  name = var.app_name
}

resource "aws_elastic_beanstalk_application_version" "app_version" {
  name        = "${var.app_name}-version"
  application = aws_elastic_beanstalk_application.app.name
  bucket      = aws_s3_bucket.ebs.id
  key         = aws_s3_object.ebs_deployment.id
}

resource "aws_elastic_beanstalk_environment" "env" {
  application            = aws_elastic_beanstalk_application.app.name
  name                   = var.app_name
  version_label          = aws_elastic_beanstalk_application_version.app_version.name
  solution_stack_name    = "64bit Amazon Linux 2023 v4.0.1 running Docker"
  tier                   = "WebServer"
  wait_for_ready_timeout = "10m"
  setting {
    name      = "InstancePort"
    namespace = "aws:cloudformation:template:parameter"
    value     = var.container_port
  }
  setting {
    name      = "IamInstanceProfile"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = aws_iam_instance_profile.beanstalk_iam_instance_profile.arn
  }
  setting {
    name      = "SecurityGroups"
    namespace = "aws:autoscaling:launchconfiguration"
    value = join(",", [
      # additional security groups. e.g. database security group, etc.
    ])
  }
  setting {
    name      = "VPCId"
    namespace = "aws:ec2:vpc"
    value     = var.vpc_id
  }
  setting {
    name      = "Subnets"
    namespace = "aws:ec2:vpc"
    value     = join(",", var.public_subnet_ids)
  }
  setting {
    name      = "SSLCertificateId"
    namespace = "aws:elb:loadbalancer"
    value     = aws_acm_certificate.cert.certificate_id
  }
}