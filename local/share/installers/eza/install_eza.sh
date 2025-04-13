#!/usr/bin/env bash

# apt list eza*
# eza/noble 0.18.2-1 amd64

brew info eza
# ==> eza: stable 0.21.0

mise plugins ls-remote | grep eza
mise ls-remote eza
# 0.21.0

mise install eza
mise use --global eza

which -a eza
eza --version

eza -la
