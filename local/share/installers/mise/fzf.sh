#!/usr/bin/env bash

FLAVOR=${1:-brew}

case "$FLAVOR" in
apt)
  apt list fzf
  # ==> fzf/noble-updates,noble-security 0.44.1-1ubuntu0.1 amd64
  sudo apt -y install fzf
  apt list --installed fzf
  ;;
mise)
  mise plugins ls-remote | grep fzf
  mise ls-remote fzf
  # ==> 0.54.1
  mise install fzf
  mise use --global fzf
  ;;
*brew)
  brew info fzf
  # ==> fzf: stable 0.54.1 (bottled), HEAD
  brew install fzf
  ;;
git*)
  mkdir -p ~/.local/src/github.com/junegunn
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/src/github.com/junegunn/fzf
  ~/.local/src/github.com/junegunn/fzf/install --xdg --key-bindings --completion --no-fish --no-update-rc
  ;;
*)
  echo 'usage: ./fzf.sh (apt|mise|brew|git) # brew is default.' >&2
  exit 1
  ;;
esac

which -a fzf
fzf --version
