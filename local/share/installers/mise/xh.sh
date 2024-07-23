#!/usr/bin/env bash

mise plugins ls-remote | grep xh

# apt list xh

# 0.22.2
mise ls-remote xh

# sudo apt -y install xh
# apt list --installed xh

# deps
#sudo apt -y install
mise install xh
mise use --global xh

which -a xh
xh --version
