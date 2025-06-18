#! /bin/bash
# This script initializes the environment for the project.
# It sets up the necessary directories and files.
# Usage: ./init.sh

echo "dnf repo initialization..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

echo "Installing dependencies..."
sudo dnf install qemu-kvm libvirt libguestfs-tools virt-install rsync ansible code helm -y
sudo usermod -aG libvirt ${USER}

echo "Enabling and starting services..."
sudo systemctl enable --now libvirtd
sudo dnf install vagrant -y
vagrant plugin install vagrant-libvirt

echo "Installing k8s..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


echo "Installing k3d..."
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash


sudo dnf remove podman-docker -y
sudo dnf install docker-cli containerd -y
sudo systemctl enable --now docker
sudo systemctl enable --now containerd
sudo usermod -aG docker ${USER}

echo "force ip forwarding"
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf                                                   
sudo sysctl -p

sudo reboot

