#!/bin/bash
# https://learn.microsoft.com/ja-jp/windows/wsl/systemd#how-to-enable-systemd

# wsl.exe --version

if ! grep -q systemd=true /etc/wsl.conf; then
  cat <<EOF | sudo tee /etc/wsl.conf
[boot]
systemd=true
EOF
fi

cat /etc/wsl.conf

systemctl list-unit-files --type=service --no-pager
