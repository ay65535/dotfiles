#!/bin/bash
# https://argo-cd.readthedocs.io/en/stable/cli_installation/

if [ "$(uname -m)" = "x86_64" ]; then
  # if x64, install via brew
  brew install argocd

elif [ "$(uname -m)" = "arm64" ]; then
  # if arm64, install via curl
  curl -sSL -o argocd-linux-arm64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-arm64
  sudo install -m 555 argocd-linux-arm64 /usr/local/bin/argocd
  rm argocd-linux-arm64
fi
