#!/bin/bash

# shellcheck disable=SC2154
if [ "${https_proxy:-}" = '' ]; then
  echo "https_proxy not defined." >&2
  exit 1
fi

TARGET=/etc/apt/apt.conf.d/00proxy
# ls -la $TARGET

# backup
if [ -f ${TARGET} ] && [ ! -f ${TARGET}.orig ]; then
  sudo mv ${TARGET} ${TARGET}.orig
  sudo cp -a ${TARGET}.orig ${TARGET}
fi

if grep -q https_proxy= ${TARGET}; then
  echo "${TARGET} already configured."
else
  # shellcheck disable=SC2154
  cat <<EOF | sudo tee ${TARGET}
Acquire::https::proxy "$https_proxy";
Acquire::http::proxy "$http_proxy";
Acquire::ftp::proxy "${ftp_proxy:-$http_proxy}";
EOF

fi

# check
cat $TARGET

# restore
# sudo rm ${TARGET}
# sudo rm ${TARGET}.orig
