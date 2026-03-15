#!/bin/bash

# shellcheck disable=SC2154
if [ "${https_proxy:-}" = '' ]; then
  echo "https_proxy not defined." >&2
  exit 1
fi

#TARGET="$HOME/.docker/config.json"
TARGET="${XDG_CONFIG_HOME:-$HOME/.config}/docker/config.json"
# ls -la ${TARGET%/*}

if [ ! -d "${TARGET%/*}" ]; then
  mkdir -p "${TARGET%/*}"
fi

# backup
if [ -f "$TARGET" ] && [ ! -f "$TARGET".orig ]; then
  sudo mv "$TARGET" "$TARGET".orig
  sudo cp -a "$TARGET".orig "$TARGET"
fi

if grep -q https_proxy= "$TARGET"; then
  echo "$TARGET already configured."
else
  # shellcheck disable=SC2154
  cat <<EOF >"$TARGET"
{
    "proxies": {
        "default": {
            "httpProxy": "${http_proxy:?}",
            "httpsProxy": "${https_proxy:?}"
            "noProxy": "${no_proxy:?}"
        }
    }
}
EOF

fi

# check
cat "$TARGET"

# restore
# sudo rm ${TARGET}
# sudo rm ${TARGET}.orig

#
# Daemon proxy
#

# https://docs.docker.com/engine/daemon/proxy/

# check
sudo systemctl show --property=Environment docker

# MEMO:
#   /etc/docker/daemon.json はdockerの設定ファイル
#   /etc/systemd/system/docker.service.d/http-proxy.conf はsystemdの設定ファイル
#   両方指定した場合はdaemon.jsonが優先される

sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<EOF
{
  "proxies": {
    "http-proxy": "${http_proxy:?}",
    "https-proxy": "${https_proxy:?}",
    "no-proxy": "${no_proxy:?}"
  }
}
EOF

# daemon再起動
sudo systemctl restart docker
