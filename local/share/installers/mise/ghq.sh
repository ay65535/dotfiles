#!/usr/bin/env bash

mise plugins ls-remote | grep ghq

# none
# apt list ghq

# 0.54.0
mise ls-remote ghq

# deps
sudo apt -y install unzip

mise install ghq
mise use --global ghq

apt list --installed ghq*
mise ls

which -a ghq
ghq --version
