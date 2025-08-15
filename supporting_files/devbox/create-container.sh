#!/bin/sh

podman run --name devbox --platform=linux/amd64 -d \
  --privileged \
  --expose 1025-1040 -P \
  -v $HOME/code:/home/wtaylor/code \
  -v $HOME/scratch:/home/wtaylor/scratch \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --userns=keep-id:uid=$(id -u) \
  -e DOCKER_HOST=unix:///var/run/docker.sock \
  devbox:latest
