resource "aws_iam_role" "ebs" {
  name               = "${var.app_name}-ebs"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "web_tier" {
  role       = aws_iam_role.ebs.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "multicontainer_docker" {
  role       = aws_iam_role.ebs.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_role_policy_attachment" "worker_tier" {
  role       = aws_iam_role.ebs.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_iam_role_policy_attachment" "ecr" {
  role       = aws_iam_role.ebs.name
  policy_arn = aws_iam_policy.ecr.arn
}

resource "aws_iam_instance_profile" "beanstalk_iam_instance_profile" {
  name = "${local.app_name}-beanstalk-iam-instance-profile"
  role = aws_iam_role.ebs.name
}