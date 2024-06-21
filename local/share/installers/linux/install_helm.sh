#!/bin/bash
# https://helm.sh/ja/docs/intro/install/

if [ "$(uname -m)" = "x86_64" ]; then
  # if x64, install via brew
  brew install helm

elif [ "$(uname -m)" = "arm64" ]; then
  # if arm64, install via curl
  curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg >/dev/null
  sudo apt-get install apt-transport-https --yes
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
  sudo apt-get update
  sudo apt-get install helm
fi
