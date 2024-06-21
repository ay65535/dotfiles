#!/bin/bash

# ネイティブなパッケージマネージャーを使用してインストールする
# https://kubernetes.io/ja/docs/tasks/tools/install-kubectl/#%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AA%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%83%9E%E3%83%8D%E3%83%BC%E3%82%B8%E3%83%A3%E3%83%BC%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%97%E3%81%A6%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B
# https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
sudo apt-get update
sudo apt-get install -y apt-transport-https gnupg2               # kubectl
sudo apt-get install -y apt-transport-https ca-certificates curl # kubeadm

#curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -  # kubectl
#sudo curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg # kubeadm
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg

# kubectl
#echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
# kubeadm
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
#sudo apt-get install -y kubectl
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
