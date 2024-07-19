#!/usr/bin/env bash

mise plugins ls-remote | grep bat

# bat/noble 0.24.0-1build1 amd64
# apt list bat

# 0.24.0
mise ls-remote bat

# sudo apt -y install bat
# apt list --installed bat

# deps
#sudo apt -y install
mise install bat
mise use bat

which -a bat
bat --version

bat ~/.bashrc
