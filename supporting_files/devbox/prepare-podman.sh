#!/bin/sh

sudo /opt/homebrew/Cellar/podman/5.5.2_1/bin/podman-mac-helper install
podman machine init --now --cpus=7 --memory=24576 --disk-size=128 --username wtaylor
