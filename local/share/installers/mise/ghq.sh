#!/usr/bin/env bash

# none
# apt list ghq*

brew info ghq
# ==> ghq: stable 1.6.2 (bottled), HEAD
brew install ghq

# mise plugins ls-remote | grep ghq
# mise ls-remote ghq
# # ==> 1.6.2
# sudo apt -y install unzip # deps
# mise install ghq
# mise use --global ghq
# mise ls ghq
# mise uninstall --all ghq && mise plugins uninstall --purge ghq # uninstall
# rm ~/.local/share/mise/shims/ghq_use_asdf
# mise reshim
# mise doctor

which -a ghq
ghq --version
