#!/usr/bin/env bash

# apt list *sheldon*
# -
# sudo apt -y install sheldon
# apt list --installed sheldon

# brew info sheldon
# brew install sheldon
# ==> sheldon: stable 0.8.1 (bottled), HEAD

mise plugins ls-remote | grep sheldon
mise ls-remote sheldon

curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh |
  bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin

sudo apt -y install pkg-config libssl-dev # deps
mise install cargo:sheldon
# mise use --global cargo:sheldon
# cargo install cargo-binstall
# cargo binstall --root ~/.local sheldon
# cargo install sheldon
# cargo install --root ~/.local sheldon
# cargo uninstall --root ~/.local sheldon
export PATH="$HOME/.local/bin:$PATH"

which -a sheldon
sheldon --version
# =>
# sheldon 0.7.4 (9a56dcfc7 2023-11-19)
# rustc 1.74.0 (79e9716c9 2023-11-13)
# =>
# sheldon 0.7.4
# rustc 1.80.0 (051478957 2024-07-21)
