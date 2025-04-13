#!/usr/bin/env bash

# apt list ripgrep
# ripgrep/stable 13.0.0-4+b2 arm64
# ripgrep/noble 14.1.0-1 amd64
# sudo apt -y install ripgrep
# apt list --installed ripgrep

# brew info ripgrep
# ==> ripgrep: stable 14.1.1 (bottled), HEAD

mise plugins ls-remote | grep ripgrep
mise ls-remote ripgrep
# 14.1.1
mise install ripgrep
mise use --global ripgrep

which -a rg
rg --version
rg HIST ~/.bashrc
