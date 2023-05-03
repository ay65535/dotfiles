#!/bin/bash
# https://code.visualstudio.com/docs/remote/tunnels

QUALITY=${1:-stable}
PLATFORM=$(dpkg --print-architecture)

# if QUALITY is not stable or insider, error & exit
if [ "$QUALITY" != "stable" ] && [ "$QUALITY" != "insider" ]; then
  echo "Error: QUALITY is not 'stable' or 'insider'"
  exit 1
fi

# for linux x64/arm64
curl -Lk "https://code.visualstudio.com/sha/download?build=$QUALITY&os=cli-alpine-$PLATFORM" --output vscode_cli.tar.gz

tar -xf vscode_cli.tar.gz -C ~/.local/bin/
rm vscode_cli.tar.gz

# execute
code --help
code version show
code status
code update
code tunnel status
code tunnel prune
code tunnel user show
code tunnel user login
code tunnel service log
code tunnel service install
# =>
# info Successfully registered service...
# info Successfully enabled unit files...
# error error starting service: org.freedesktop.systemd1.NoSuchUnit: Unit code-tunnel.service not found.

systemctl --user daemon-reload
systemctl --user status code-tunnel
systemctl --user restart code-tunnel

# code tunnel service uninstall
