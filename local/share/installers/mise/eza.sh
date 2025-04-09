#!/usr/bin/env bash

mise plugins ls-remote | grep eza

# eza/noble 0.18.2-1 amd64
# apt list eza*

# 0.21.0
mise ls-remote eza

mise install eza
mise use --global eza

which -a eza
eza --version

eza -la
