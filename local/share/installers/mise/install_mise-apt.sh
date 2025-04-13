#!/bin/bash
# https://mise.jdx.dev/installing-mise.html#apt

sudo apt update -y && sudo apt install -y gpg sudo wget curl
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1>/dev/null
ARCH=$(dpkg --print-architecture) # アーキテクチャを取得
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=${ARCH}] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt update
apt list mise
sudo apt install -y mise

# which -a mise
# mise --version
# mkdir -p "$XDG_DATA_HOME"/bash-completion/completions
# mise completion "${SHELL##*/}" >"$XDG_DATA_HOME"/bash-completion/completions/mise
# ls -la "$XDG_DATA_HOME"/bash-completion/completions
# sudo rm /etc/apt/sources.list.d/mise.list
