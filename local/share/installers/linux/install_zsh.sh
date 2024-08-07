#!/bin/bash

VARIANT=${1:-apt}

echo "VARIANT='$VARIANT' # (apt|brew)"
# read -rp "Input VARIANT value or enter: " INPUT
# VARIANT=${INPUT:-$VARIANT}
# echo "VARIANT='$VARIANT'"

case "$VARIANT" in
apt)
  # sudo apt update
  apt list zsh
  # ==> zsh/noble,noble 5.9-6ubuntu2 amd64
  sudo apt -y install zsh
  ;;
brew)
  # brew update
  brew info zsh
  # ==> zsh: stable 5.9 (bottled), HEAD
  # read -rp "Press enter to continue"
  brew install zsh
  # Uninstall #
  # brew remove zsh
  ;;
esac

cat /etc/shells
chsh -s /bin/zsh
