#!/bin/bash

# https://zenn.dev/khirotaka/articles/e73ba496ce7b29#k3s%E3%81%A7gpu%E5%88%A9%E7%94%A8%E5%8F%AF%E8%83%BD%E3%81%AB%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AE%E4%B8%8B%E6%BA%96%E5%82%99

# toolkitのバージョンアップ
DISTRIBUTION=$(. /etc/os-release;echo $ID$VERSION_ID)
# echo $DISTRIBUTION

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
#curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list |
curl -s -L https://nvidia.github.io/libnvidia-container/experimental/$DISTRIBUTION/libnvidia-container.list |
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' |
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
cat /etc/apt/sources.list.d/nvidia-container-toolkit.list
# これを実行したら

sudo apt update && sudo apt upgrade -y
# を行い再起動する。

# -----

sudo dpkg -l nvidia-container-toolkit
# before: ii  nvidia-container-toolkit 1.7.0-1       arm64 NVIDIA container runtime hook
# after:  ii  nvidia-container-toolkit 1.17.0~rc.2-1 arm64 NVIDIA Container toolkit

# 次にNVIDIA Device Plugin のインストールの準備として /etc/docker/daemon.json を修正する。
# 内容としてはこの通り
# {
#     "default-runtime": "nvidia",
#     "runtimes": {
#         "nvidia": {
#             "path": "/usr/bin/nvidia-container-runtime",
#             "runtimeArgs": []
#         }
#     }
# }
# cat /etc/docker/daemon.json

docker info | grep -i runtime
#  Runtimes: nvidia runc io.containerd.runc.v2 io.containerd.runtime.v1.linux
