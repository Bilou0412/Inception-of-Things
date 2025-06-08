#!/usr/bin/env bash
sudo dnf install docker-cli containerd
sudo dnf install docker-compose
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
sudo systemctl enable --now docker 
sudo systemctl enable --now containerd
sudo usermod -aG docker bmoudach
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl