#!/usr/bin/env bash

mise plugins ls-remote | grep zoxide

# zoxide/noble 0.9.3-1 amd64
apt list zoxide

# 0.9.4
mise ls-remote zoxide

# sudo apt -y install zoxide
# apt list --installed zoxide

# deps
# sudo apt -y install
mise install zoxide
mise use zoxide

# cargo install zoxide

which -a zoxide
zoxide --version

zoxide
