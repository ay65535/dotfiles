#!/bin/bash

# https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/install.md#net-tool

if ! command -v dotnet >/dev/null; then
  echo "dotnet not found" >&2
  echo "Please install dotnet first: install_dotnet.sh" >&2
  return 1
fi

# Install
dotnet tool install -g git-credential-manager

# Configure
git-credential-manager configure

# Update
#dotnet tool update -g git-credential-manager

# Uninstall
#git-credential-manager unconfigure
#dotnet tool uninstall -g git-credential-manager
