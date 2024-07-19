#!/usr/bin/env bash

mise plugins ls-remote | grep fd

# fd-find/noble 9.0.0-1 amd64
# apt list fd*
# apt show fd-find

# 10.1.0
mise ls-remote fd

# deps
#sudo apt -y install

# sudo apt -y install fd-find
mise install fd
mise use fd

apt list --installed fd*

which -a fd
fd --version

fd . ~/.dotfiles
