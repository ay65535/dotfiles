#!/bin/bash

#
# apt mirror 変更
#

if [ ! -f /etc/apt/sources.list.orig ]; then
  sudo cp /etc/apt/sources.list /etc/apt/sources.list.orig
fi
cat /etc/apt/sources.list /etc/apt/sources.list.orig
# ==>
# deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
# deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
# deb http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware

cat <<EOF | sudo tee /etc/apt/sources.list
deb https://ftp.udx.icscoe.jp/Linux/debian bookworm main contrib non-free non-free-firmware
deb https://ftp.udx.icscoe.jp/Linux/debian bookworm-updates main contrib non-free non-free-firmware
deb http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
EOF

if [ ! -f /etc/apt/sources.list.d/raspi.list.orig ]; then
  sudo cp /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.orig
fi
cat /etc/apt/sources.list.d/raspi.list.orig
# ==> deb http://archive.raspberrypi.com/debian/ bookworm main

# Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)). という警告を修正
sudo mkdir -m 0755 -p /etc/apt/keyrings/

# 鍵ID: E77FC0EC34276B4B のRaspbian公開鍵を取得
curl -fsSL 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xE77FC0EC34276B4B' |
  gpg --dearmor |
    sudo tee /etc/apt/keyrings/raspbian-archive-keyring.gpg >/dev/null

# リポジトリの設定を追加し、取得した鍵を使用
echo 'deb [signed-by=/etc/apt/keyrings/raspbian-archive-keyring.gpg] https://ftp.udx.icscoe.jp/Linux/raspbian/multiarch bookworm main' |
  sudo tee /etc/apt/sources.list.d/raspi.list

cat /etc/apt/sources.list.d/raspi.list

# N: Skipping acquire of configured file 'main/binary-armhf/Packages' as repository 'https://ftp.udx.icscoe.jp/Linux/raspbian/multiarch bookworm InRelease' doesn't support architecture 'armhf' という警告を修正
dpkg --print-architecture
dpkg --print-foreign-architectures
sudo dpkg --remove-architecture armhf

#
# パッケージ最新化
#

sudo apt update
apt list --upgradable
sudo apt -y upgrade
sudo apt -y full-upgrade
sudo apt -y autoremove
sudo apt clean

#
# パッケージインストール
#
