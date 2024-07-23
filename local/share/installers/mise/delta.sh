#!/usr/bin/env bash

mise plugins ls-remote | grep delta

# apt list delta

# 0.17.0
mise ls-remote delta

# deps
#sudo apt -y install

# sudo apt -y install delta
mise install delta
mise use --global delta

apt list --installed delta*

which -a delta
delta --version
