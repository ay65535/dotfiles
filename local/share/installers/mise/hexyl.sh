#!/usr/bin/env bash

mise plugins ls-remote | grep hexyl

# hexyl/noble 0.8.0-2 amd64
# apt list hexyl

# ==> hexyl: stable 0.14.0 (bottled), HEAD
brew info hexyl
brew install hexyl

# mise ls-remote hexyl

sudo apt -y install hexyl
apt list --installed hexyl

# deps
# sudo apt -y install
# mise install hexyl
# mise use --global hexyl

which -a hexyl
hexyl --version

hexyl ~/.bashrc
