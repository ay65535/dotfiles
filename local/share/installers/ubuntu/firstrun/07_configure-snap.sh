#!/bin/bash
# https://redj.hatenablog.com/entry/2020/07/24/224620

if [ "${https_proxy:-}" = "" ]; then
  echo "https_proxy not defined." >&2
  return
fi

# shellcheck disable=SC2154
sudo snap set system proxy.http="$http_proxy"
sudo snap get system proxy.http

sudo snap set system proxy.https="$https_proxy"
sudo snap get system proxy.https
