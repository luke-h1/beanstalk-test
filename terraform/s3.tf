resource "random_pet" "ebs_bucket_name" {}

resource "aws_s3_bucket" "ebs" {
  bucket = "${var.app_name}-${random_pet.ebs_bucket_name.id}"
}



resource "aws_s3_object" "ebs_deployment" {
  bucket     = aws_s3_bucket.ebs.id
  key        = "Dockerrun.aws.json"
  source = jsonencode({
    "AWSEBDockerrunVersion" : "1",
    "Image" : {
      "Name" : "${aws_ecr_repository.app.repository_url}:latest",
      "Update" : "true"
    },
    "Ports" : [
      {
        "ContainerPort" : "8000",
        "HostPort" : "8000"
      }
    ],
    "Entrypoint" : "/root/app",
    "Command" : "arg"


  })
  lifecycle {
    replace_triggered_by = [local_file.ebs_config]
  }
}