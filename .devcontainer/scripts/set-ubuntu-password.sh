#!/usr/bin/env bash
set -euo pipefail

: "${DOTFILES_UBUNTU_PASSWORD:?Set DOTFILES_UBUNTU_PASSWORD on host first}"

echo "ubuntu:${DOTFILES_UBUNTU_PASSWORD}" | chpasswd
