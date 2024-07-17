#!/usr/bin/env bash

VARIANT=${1:-default}

echo "VARIANT='$VARIANT' # (default|ppa|pparc|brew)"
read -rp "Input VARIANT value or enter: " INPUT
VARIANT=${INPUT:-$VARIANT}
echo "VARIANT='$VARIANT'"

case "$VARIANT" in
default)
  # 2.34.1 (22.04)
  sudo apt update
  apt list -a git
  sudo apt install git
  ;;
ppa)
  # For Ubuntu, this PPA provides the latest stable upstream Git version
  # 2.43.2 (2024-05-14)
  sudo add-apt-repository ppa:git-core/ppa
  sudo apt update
  apt list -a git
  sudo apt install git
  # Uninstall #
  # sudo apt remove --purge git
  # sudo add-apt-repository --remove ppa:git-core/ppa
  ;;
pparc)
  # For Ubuntu, this PPA provides the latest release candidates of Git version
  # 2.45.0 (2024-05-14)
  sudo add-apt-repository ppa:git-core/candidate
  sudo apt update
  apt list -a git
  sudo apt -y upgrade git
  # sudo apt -y install git
  ;;
brew)
  brew search git
  # 2.45.0 (2024-05-14)
  brew info git
  read -rp "Press enter to continue"
  brew install git
  # Uninstall #
  #brew remove git
  ;;
esac
