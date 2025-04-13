#!/usr/bin/env bash

# apt list fd*
# apt show fd-find
# fd-find/stable 8.6.0-3 arm64
# fd-find/noble 9.0.0-1 amd64
# sudo apt -y install fd-find
# apt list --installed fd*

# brew info fd
# ==> fd: stable 10.2.0 (bottled), HEAD

mise plugins ls-remote | grep fd
mise ls-remote fd
# 10.2.0
mise install fd
mise use --global fd

which -a fd
fd --version
fd . ~/.dotfiles
