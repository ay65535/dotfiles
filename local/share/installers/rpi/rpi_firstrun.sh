#!/bin/bash

#
# apt mirror 変更
#

if [ ! -f /etc/apt/sources.list.orig ]; then
  sudo cp /etc/apt/sources.list /etc/apt/sources.list.orig
fi

cat <<EOF | sudo tee /etc/apt/sources.list
deb https://ftp.udx.icscoe.jp/Linux/debian bookworm main contrib non-free non-free-firmware
deb http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
deb https://ftp.udx.icscoe.jp/Linux/debian bookworm-updates main contrib non-free non-free-firmware
EOF

if [ ! -f /etc/apt/sources.list.d/raspi.list.orig ]; then
  sudo cp /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.orig
fi

# 以下のような警告を解消
# Get:4 https://ftp.udx.icscoe.jp/Linux/raspbian/multiarch bookworm InRelease [3,918 B]
# Err:4 https://ftp.udx.icscoe.jp/Linux/raspbian/multiarch bookworm InRelease
#   The following signatures couldn't be verified because the public key is not available: NO_PUBKEY E77FC0EC34276B4B
# Reading package lists... Done
# W: GPG error: https://ftp.udx.icscoe.jp/Linux/raspbian/multiarch bookworm InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY E77FC0EC34276B4B
# E: The repository 'https://ftp.udx.icscoe.jp/Linux/raspbian/multiarch bookworm InRelease' is not signed.
# N: Updating from such a repository can't be done securely, and is therefore disabled by default.
# N: See apt-secure(8) manpage for repository creation and user configuration details.

apt-key list >apt-key.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E77FC0EC34276B4B

# Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)). という警告を修正
sudo apt-key export E77FC0EC34276B4B | sudo gpg --dearmor -o /usr/share/keyrings/raspbian-archive-keyring.gpg

echo 'deb [signed-by=/usr/share/keyrings/raspbian-archive-keyring.gpg] https://ftp.udx.icscoe.jp/Linux/raspbian/multiarch bookworm main' | sudo tee /etc/apt/sources.list.d/raspi.list
cat /etc/apt/sources.list.d/raspi.list

# N: Skipping acquire of configured file 'main/binary-armhf/Packages' as repository 'https://ftp.udx.icscoe.jp/Linux/raspbian/multiarch bookworm InRelease' doesn't support architecture 'armhf' という警告を修正
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
