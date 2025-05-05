#!/bin/bash

#
# proxy setting
#

# shellcheck disable=SC2154
if [ "$http_proxy" = "" ] || [ "$https_proxy" = "" ]; then
  echo "Yout must set \$http_proxy and \$https_proxy first." >&2
  return
fi

# cat <<EOF | sudo tee /etc/apt/apt.conf.d/00_proxy
# Acquire::http::Proxy "$http_proxy";
# Acquire::https::Proxy "$https_proxy";
# EOF

# ll /etc/apt/apt.conf.d
# cat /etc/apt/apt.conf.d/00_proxy

#
# source setting
#

# backup
# sudo cp -fb --backup=numbered /etc/apt/sources.list{,}
# ll /etc/apt/sources.list*

cat /etc/os-release
. /etc/os-release

ARCH=$(dpkg --print-architecture)

case "$VERSION_ID" in
24.04)
  cat /etc/apt/sources.list*
  cat /etc/apt/sources.list.d/ubuntu.sources

  #   cat <<EOF | sudo tee /etc/apt/sources.list.d/icscoe.list
  # deb https://ftp.udx.icscoe.jp/Linux/ubuntu/ $VERSION_CODENAME main
  # # deb-src https://ftp.udx.icscoe.jp/Linux/ubuntu/ $VERSION_CODENAME main
  # EOF
  sudo sed -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list.d/ubuntu.sources | sudo tee /etc/apt/sources.list.d/icscoe.sources
  sudo mv /etc/apt/sources.list.d/ubuntu.sources{,.orig}

  ls -l /etc/apt/sources.list*
  ;;
*)
  sudo cp -a /etc/apt/sources.list{,.orig}
  cat /etc/apt/sources.list.orig
  # ==>
  # deb http://ports.ubuntu.com/ubuntu-ports/ bionic main restricted universe multiverse
  # deb http://ports.ubuntu.com/ubuntu-ports/ bionic-updates main restricted universe multiverse
  # deb http://ports.ubuntu.com/ubuntu-ports/ bionic-backports main restricted universe multiverse
  # deb http://ports.ubuntu.com/ubuntu-ports/ bionic-security main restricted universe multiverse

  case $ARCH in
  arm64)
    SECURITY_URL=http://ports.ubuntu.com/ubuntu-ports/
    FALLBACK_URL=http://ports.ubuntu.com/ubuntu-ports/
    ;;
  amd64)
    SECURITY_URL=http://security.ubuntu.com/ubuntu/
    FALLBACK_URL=http://archive.ubuntu.com/ubuntu/
    ;;
  *)
    echo "Unknown architecture: $ARCH" >&2
    echo "Please check your architecture." >&2
    echo "You can use the following command to check your architecture:" >&2
    echo "  dpkg --print-architecture" >&2
    ;;
  esac
  echo "Using SECURITY_URL: $SECURITY_URL"
  echo "Using FALLBACK_URL: $FALLBACK_URL"

  grep -Ev '^\s*#' /etc/apt/sources.list | sort
  grep deb-src /etc/apt/sources.list | sort

  cat <<EOF | sudo tee /etc/apt/sources.list
#
# https://hirose31.hatenablog.jp/entry/2023/04/19/194532
#

deb mirror+file:/etc/apt/mirrors.txt ${VERSION_CODENAME} main restricted universe multiverse
deb mirror+file:/etc/apt/mirrors.txt ${VERSION_CODENAME}-updates main restricted universe multiverse
deb mirror+file:/etc/apt/mirrors.txt ${VERSION_CODENAME}-backports main restricted universe multiverse
deb ${SECURITY_URL} ${VERSION_CODENAME}-security main restricted universe multiverse
# deb-src mirror+file:/etc/apt/mirrors.txt ${VERSION_CODENAME} main restricted universe multiverse
# deb-src mirror+file:/etc/apt/mirrors.txt ${VERSION_CODENAME}-updates main restricted universe multiverse
# deb-src ${SECURITY_URL} ${VERSION_CODENAME}-security main restricted universe multiverse

cat <<EOF | sudo tee /etc/apt/mirrors.txt
#
# https://hirose31.hatenablog.jp/entry/2023/04/19/194532
#

# http://ap-northeast-1.ec2.archive.ubuntu.com/ubuntu/$(printf '\t')priority:1
# http://asia-northeast1.gce.archive.ubuntu.com/ubuntu/$(printf '\t')priority:1
https://ftp.udx.icscoe.jp/Linux/ubuntu/$(printf '\t')priority:2
https://linux.yz.yamagata-u.ac.jp/ubuntu/$(printf '\t')priority:3
${FALLBACK_URL}
EOF

  cat -T /etc/apt/mirrors.txt
  # sudo vim /etc/apt/mirrors.txt
  ;;
esac

# Delete old cache
sudo rm -rf /var/lib/apt/lists/*
