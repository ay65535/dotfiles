#!/bin/bash

# microk8s は /etc/environment にこの設定が必要

# shellcheck disable=SC2154
if [ "${https_proxy:-}" = '' ]; then
  echo "https_proxy not defined." >&2
  exit 1
fi

#TARGET=/etc/environment
#PREFIX=''

TARGET=/etc/profile.d/00-proxy.sh
PREFIX='export '

# backup
if [ -f ${TARGET} ] && [ ! -f ${TARGET}.orig ]; then
  sudo mv ${TARGET} ${TARGET}.orig
  sudo cp -a ${TARGET}.orig ${TARGET}
fi

if grep -q https_proxy= ${TARGET}; then
  echo "${TARGET} already configured."
else
  # shellcheck disable=SC2154
  cat <<EOF | sudo tee -a ${TARGET}
# system-wide proxy settings
${PREFIX}http_proxy="${http_proxy:-$https_proxy}"
${PREFIX}HTTP_PROXY="${http_proxy:-$https_proxy}"
${PREFIX}https_proxy="$https_proxy"
${PREFIX}HTTPS_PROXY="$https_proxy"
${PREFIX}no_proxy="${no_proxy:-127.0.0.1,localhost,192.168.250.0/24,192.168.0.0/24,10.6.80.0/23,172.16.0.0/12,::1}"
${PREFIX}NO_PROXY="${no_proxy:-127.0.0.1,localhost,192.168.250.0/24,192.168.0.0/24,10.6.80.0/23,172.16.0.0/12,::1}"
EOF

fi

# check
cat $TARGET

# restore
# sudo rm ${TARGET}
# sudo mv ${TARGET}.orig ${TARGET}
