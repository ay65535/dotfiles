#!/bin/bash

#
# proxy setting
#

if [ "$http_proxy" != "" ] || [ "$https_proxy" != "" ]; then
  echo "Yout must set \$http_proxy and \$https_proxy first." >&2
  return
fi

cat <<EOF | sudo tee /etc/apt/apt.conf.d/00proxy
Acquire::http::Proxy "$http_proxy";
Acquire::https::Proxy "$https_proxy";
EOF

ll /etc/apt/apt.conf.d
cat /etc/apt/apt.conf.d/00proxy

#
# source setting
#

# backup
sudo cp -fb --backup=numbered /etc/apt/sources.list{,}
ll -d /etc/apt/sources.list*

#cat /etc/apt/sources.list | grep -Ev '^\s*#' | sort
#cat /etc/apt/sources.list | grep deb-src | sort
cat /etc/apt/sources.list*
cat <<EOF | sudo tee /etc/apt/sources.list
#
# https://hirose31.hatenablog.jp/entry/2023/04/19/194532
#

deb mirror+file:/etc/apt/mirrors.txt jammy main restricted universe multiverse
deb mirror+file:/etc/apt/mirrors.txt jammy-updates main restricted universe multiverse
deb mirror+file:/etc/apt/mirrors.txt jammy-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse
# deb-src mirror+file:/etc/apt/mirrors.txt jammy main restricted universe multiverse
# deb-src mirror+file:/etc/apt/mirrors.txt jammy-updates main restricted universe multiverse
# deb-src http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse
EOF

cat <<EOF | sudo tee /etc/apt/mirrors.txt
#
# https://hirose31.hatenablog.jp/entry/2023/04/19/194532
#

# http://ap-northeast-1.ec2.archive.ubuntu.com/ubuntu/	priority:1
# http://asia-northeast1.gce.archive.ubuntu.com/ubuntu/	priority:1
https://ftp.udx.icscoe.jp/Linux/ubuntu/	priority:2
https://linux.yz.yamagata-u.ac.jp/ubuntu/	priority:3
http://archive.ubuntu.com/ubuntu/
EOF

cat -T /etc/apt/mirrors.txt
