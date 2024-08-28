#!/bin/bash

ECR_URL="753493924839.dkr.ecr.eu-west-2.amazonaws.com"
ECR_NAME="beanstalk-poc"
REGION=eu-west-2

docker build -t $ECR_URL/$ECR_NAME:latest .
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_URL
docker push $ECR_URL/$ECR_NAME:latest
