#!/bin/bash

# microk8s はこの設定が必要

# shellcheck disable=SC2154
if [ "${https_proxy:-}" = '' ]; then
  echo "https_proxy not defined." >&2
  exit 1
fi

# backup
if [ ! -f /etc/environment.orig ]; then
  sudo mv /etc/environment /etc/environment.orig
  sudo cp -a /etc/environment.orig /etc/environment
fi

if grep -q https_proxy= /etc/environment; then
  echo "/etc/environment already configured."
else
  # shellcheck disable=SC2154
  cat <<EOF | sudo tee -a /etc/environment

http_proxy=$http_proxy
HTTP_PROXY=$http_proxy
https_proxy=$https_proxy
HTTPS_PROXY=$https_proxy
no_proxy=$no_proxy
NO_PROXY=$no_proxy
EOF

fi

# check
cat /etc/environment
