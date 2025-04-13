#!/bin/bash

if macos; then
  brew install fzf
else
  mkdir -p ~/.local/src/github.com/junegunn
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/src/github.com/junegunn/fzf
  ~/.local/src/github.com/junegunn/fzf/install --xdg --key-bindings --completion --no-fish --no-update-rc
fi
