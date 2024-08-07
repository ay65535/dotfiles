#!/bin/bash

VARIANT=${1:-default}

echo "VARIANT='$VARIANT' # (default|ppa|pparc|brew)"
read -rp "Input VARIANT value or enter: " INPUT
VARIANT=${INPUT:-$VARIANT}
echo "VARIANT='$VARIANT'"

case "$VARIANT" in
default)
  # sudo apt update
  apt list git
  # ==> git/noble-updates,noble-security 1:2.43.0-1ubuntu7.1 amd64 (2024-08-07)
  sudo apt install git
  ;;
ppa)
  # https://launchpad.net/~git-core/+archive/ubuntu/ppa
  # sudo apt update
  # For Ubuntu, this PPA provides the latest stable upstream Git version
  sudo add-apt-repository ppa:git-core/ppa
  apt list git
  # ==> git/noble 1:2.46.0-0ppa1~ubuntu24.04.1 amd64 (2024-08-07)
  sudo apt install git
  # Uninstall #
  # sudo apt -y remove --purge git
  # sudo add-apt-repository --remove ppa:git-core/ppa
  ;;
pparc)
  # For Ubuntu, this PPA provides the latest release candidates of Git version
  sudo add-apt-repository ppa:git-core/candidate
  sudo apt update
  apt list -a git
  sudo apt -y upgrade git
  # sudo apt -y install git
  # Uninstall #
  # sudo apt -y remove --purge git
  # sudo add-apt-repository --remove ppa:git-core/candidate
  # sudo rm /etc/apt/sources.list.d/git-core-ubuntu-candidate-noble.sources
  # ls -la /etc/apt/sources.list.d
  ;;
brew)
  brew search git
  brew info git
  # ==> git: stable 2.46.0 (bottled), HEAD (2024-08-07)
  read -rp "Press enter to continue"
  brew install git
  # Uninstall #
  #brew remove git
  ;;
mise)
  mise plugins ls-remote | grep git
  mise ls-remote git
  # ==> 2.46.0 (2024-08-07)
  mise install git
  mise use --global git
  which -a git
  git --version
  ;;
esac
