#!/usr/bin/env bash

mise plugins ls-remote | grep ripgrep

# ripgrep/noble 14.1.0-1 amd64
# apt list ripgrep

# 14.1.0
mise ls-remote ripgrep

# sudo apt -y install ripgrep
# apt list --installed ripgrep

# deps
#sudo apt -y install
mise install ripgrep
mise use ripgrep

which -a rg
rg --version

rg HIST ~/.bashrc
