#!/usr/bin/env bash

mise plugins ls-remote | grep duf

# duf/noble-updates,noble-security 0.8.1-1ubuntu0.24.04.1 amd64
apt list duf

# 0.8.1
mise ls-remote duf

# sudo apt -y install duf
# apt list --installed duf

# deps
# sudo apt -y install
mise install duf
mise use duf

# cargo install duf

which -a duf
duf --version

duf
