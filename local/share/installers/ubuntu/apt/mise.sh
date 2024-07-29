#!/bin/bash
# https://mise.jdx.dev/getting-started.html#apt

sudo apt update && sudo apt -y install gpg sudo wget curl
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1>/dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt update
sudo apt -y install mise

# mise --version
# mise completion "${SHELL##*/}" >"$XDG_DATA_HOME"/bash-completion/completions/mise
# ls -la "$XDG_DATA_HOME"/bash-completion/completions
