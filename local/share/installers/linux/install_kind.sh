#!/bin/bash

#sudo apt update && apt list kind*
# => not found

# Linuxbrew not supported on ARM processors.
#brew update
#brew install kind

if [ "$(uname -m)" = x86_64 ]; then
  # For AMD64 / x86_64
  # https://kind.sigs.k8s.io/docs/user/quick-start/#installing-with-a-package-manager
  brew install kind
elif [ "$(uname -m)" = aarch64 ]; then
  # For ARM64
  # https://kind.sigs.k8s.io/docs/user/quick-start/#installing-from-release-binaries
  curl -fsSLO https://kind.sigs.k8s.io/dl/v0.19.0/kind-linux-arm64
  chmod +x ./kind-linux-arm64
  sudo mv ./kind-linux-arm64 /usr/local/bin/kind
  ls -la /usr/local/bin/
fi
