#!/bin/bash
# https://www.guide2wsl.com/k3s/
# https://k3s.io/

# Install the k3s binary #

#K3S_VERSION="v1.29.4+k3s1"
K3S_VERSION="v1.30.2+k3s2"

archSuffix=""
if test "$(uname -m)" = "aarch64"; then
  archSuffix="-arm64"
fi
wget -q "https://github.com/k3s-io/k3s/releases/download/${K3S_VERSION}/k3s${archSuffix}" -O ~/.local/bin/k3s
chmod u+x ~/.local/bin/k3s
k3s --version

# Start the Kubernetes control plane #
sudo "$(which k3s)" server

# Merge the kubeconfig #
sudo "$(which k3s)" kubectl config rename-context default k3s
# shellcheck disable=SC2024
sudo "$(which k3s)" kubectl config view --raw >/tmp/k3s.yaml
if [ -f ~/.kube/config ]; then
  cp -p ~/.kube/config ~/.kube/config.bak
  KUBECONFIG=~/.kube/config.bak:/tmp/k3s.yaml kubectl config view --flatten >~/.kube/config
else
  mkdir ~/.kube
  install -m 400 /tmp/k3s.yaml ~/.kube/config
fi

# Test it #
sudo "$(which k3s)" kubectl config use-context k3s
sudo "$(which k3s)" kubectl version
sudo "$(which k3s)" kubectl get namespaces

# Cleanup #
sudo rm -R /var/lib/rancher/k3s/
sudo rm -R /etc/rancher/
sudo rm -R /var/lib/kubelet
sudo rm -R /var/lib/cni

