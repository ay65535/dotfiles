#!/bin/bash
# https://docs.docker.com/engine/install/ubuntu/

# Uninstall old versions
sudo apt-get -y remove docker docker-engine docker.io containerd runc
# => The following packages will be REMOVED:
# =>   containerd docker docker.io nvidia-docker2 runc

# Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt-get update
sudo apt-get -y install \
  ca-certificates \
  curl \
  gnupg

# Add Docker’s official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Use the following command to set up the repository:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
  sudo tee /etc/apt/sources.list.d/docker.list

# Update the apt package index:
sudo apt-get update

# Install Docker Engine, containerd, and Docker Compose.
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin nvidia-docker2

grep docker /etc/group
sudo usermod -aG docker "$USER"

# Verify that the Docker Engine installation is successful by running the hello-world image:
docker run --rm hello-world
