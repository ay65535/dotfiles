#!/usr/bin/env bash

mise plugins ls-remote | grep eza

# eza/noble 0.18.2-1 amd64
# apt list eza*

# 0.18.22
mise ls-remote eza

# deps
#sudo apt -y install

# sudo apt -y install eza
mise install eza
mise use eza

# apt list --installed eza*

which -a eza
eza --version

eza -la
