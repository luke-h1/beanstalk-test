#!/bin/bash

ECR_URL=
ECR_NAME=
REGION=eu-west-2

docker build -t $ECR_URL/$ECR_NAME:latest
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_URL
docker push $ECR_URL/$ECR_NAME:latest
