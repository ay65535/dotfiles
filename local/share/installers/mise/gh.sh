#!/usr/bin/env bash

#!/usr/bin/env bash

FLAVOR=${1:-apt-official}

case "$FLAVOR" in
apt)
  apt list gh
  # ==> gh/noble-updates,noble-security 2.45.0-1ubuntu0.1 amd64
  sudo apt -y install gh
  apt list --installed gh
  ;;
apt-official)
  # https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian-ubuntu-linux-raspberry-pi-os-apt
  (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) &&
    sudo mkdir -p -m 755 /etc/apt/keyrings &&
    wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
    sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
    sudo apt update &&
    sudo apt install gh -y
  apt list --installed gh
  # ==> gh/unknown,now 2.53.0 amd64
  ;;
mise)
  mise plugins ls-remote | grep github-cli
  mise ls-remote github-cli
  # ==> 2.53.0
  mise install github-cli
  mise use --global github-cli
  ;;
*brew)
  brew info gh
  # ==> gh: stable 2.53.0 (bottled), HEAD
  brew install gh
  ;;
*)
  echo 'usage: ./github-cli.sh (apt-official|apt|mise|brew) # apt-official is default.' >&2
  exit 1
  ;;
esac

which -a gh
gh --version
