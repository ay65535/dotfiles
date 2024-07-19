#!/usr/bin/env bash

mise plugins ls-remote | grep starship

# apt list *starship*

# 1.19.0
mise ls-remote starship

# sudo apt -y install starship
# apt list --installed starship

# deps
#sudo apt -y install
mise install starship
mise use starship

which -a starship
starship --version
