{
  "AWSEBDockerrunVersion": "1",
  "Image": {
    "Name": "${image_name}",
    "Update": "true"
  },
  "Ports": [
    {
      "ContainerPort": "8000",
      "HostPort": "8000"
    }
  ],
  "Entrypoint": "/root/app",
  "Command": "arg"
}