#!/bin/bash

set -e

ARCH=${1:-amd64}

if [ "$ARCH" != "amd64" ] && [ "$ARCH" != "arm64" ]; then
  echo "Invalid architecture. Supported architectures are: amd64, arm64"
  exit 1
fi

# Check if curl or wget is installed, and prioritize curl if both are installed
if command -v curl &>/dev/null; then
  DOWNLOADER="curl"
elif command -v wget &>/dev/null; then
  DOWNLOADER="wget"
else
  echo "Error: Neither curl nor wget is installed. Please install one of them to continue."
  exit 1
fi

if [ "$DOWNLOADER" == "curl" ]; then
  VERSION=$(curl -s https://go.dev/dl/ | grep -oP 'go([0-9\.]+)\.src\.tar\.gz' | head -n 1 | grep -oP 'go([0-9\.]+)')
else
  VERSION=$(wget -qO- https://go.dev/dl/ | grep -oP 'go([0-9\.]+)\.src\.tar\.gz' | head -n 1 | grep -oP 'go([0-9\.]+)')
fi
VERSION=${VERSION%.}

echo "Installing Go ${VERSION} for ${ARCH} architecture"

DOWNLOAD_URL="https://go.dev/dl/${VERSION}.linux-${ARCH}.tar.gz"

if [ "$DOWNLOADER" == "curl" ]; then
  curl -o /tmp/go.tar.gz "$DOWNLOAD_URL"
else
  wget "$DOWNLOAD_URL" -O /tmp/go.tar.gz
fi

sudo tar -C /usr/local -xzf /tmp/go.tar.gz
rm /tmp/go.tar.gz

DST_PATH=~/.profile.d/go.sh

# shellcheck source=/dev/null
source $DST_PATH

echo "Go ${VERSION} installed successfully"
echo "Please restart your shell or run 'source ~/.*profile' to update your environment variables"
