#!/usr/bin/env bash
sudo dnf install docker-cli containerd
sudo dnf install docker-compose
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash