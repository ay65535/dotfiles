#!/usr/bin/env bash

FLAVOR=${1:-mise}

case "$FLAVOR" in
apt)
  apt list zoxide
  # ==> zoxide/noble 0.9.3-1 amd64
  sudo apt -y install zoxide
  apt list --installed zoxide
  ;;
mise)
  mise plugins ls-remote | grep zoxide
  mise ls-remote zoxide
  # ==> 0.9.4
  mise install zoxide
  mise use --global zoxide
  ;;
*brew)
  brew info zoxide
  # ==> zoxide: stable 0.9.4 (bottled)
  brew install zoxide
  ;;
*)
  echo 'usage: ./zoxide.sh (apt|mise|brew) # mise is default.' >&2
  exit 1
  ;;
esac

which -a zoxide
zoxide --version

zoxide
