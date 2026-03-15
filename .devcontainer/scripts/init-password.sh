#!/usr/bin/env bash
set -euo pipefail

flag=/var/lib/devcontainer/password-initialized
install -d -m 0755 /var/lib/devcontainer

if [ ! -f "$flag" ] && [ -n "${DOTFILES_UBUNTU_PASSWORD:-}" ]; then
  echo "ubuntu:${DOTFILES_UBUNTU_PASSWORD}" | chpasswd
  touch "$flag"
fi

unset DOTFILES_UBUNTU_PASSWORD
exec "$@"
