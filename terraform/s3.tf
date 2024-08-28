resource "random_pet" "ebs_bucket_name" {}

resource "aws_s3_bucket" "ebs" {
  bucket = "${var.app_name}-${random_pet.ebs_bucket_name.id}"
}

resource "aws_s3_object" "ebs_deployment" {
  bucket = aws_s3_bucket.ebs.id
  key    = "Dockerrun.aws.json"
  source = "Dockerrun.aws.json"
}