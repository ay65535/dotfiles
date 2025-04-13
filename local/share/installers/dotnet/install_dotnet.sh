#!/bin/bash

ARCH=$(dpkg --print-architecture)

export DOTNET_CLI_TELEMETRY_OPTOUT=1

cat /etc/os-release
. /etc/os-release

case $VERSION_ID in
24.04 | 22.04)
  # https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install?pivots=os-linux-ubuntu-2404&tabs=dotnet8
  sudo apt-get update &&
    sudo apt-get install -y dotnet-sdk-8.0
  ;;

18.04)
  case $ARCH in
  *amd64 | x64*)
    # https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-1804
    wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    strings packages-microsoft-prod.deb | head
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb
    sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0
    ;;
  *arm64*)
    # https://learn.microsoft.com/en-us/dotnet/core/install/linux-scripted-manual#scripted-install
    # sudo dpkg --purge packages-microsoft-prod
    wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
    sudo chmod +x ./dotnet-install.sh
    ./dotnet-install.sh --version latest
    ;;
  *)
    echo "Unknown architecture: $ARCH" >&2
    return 1
    ;;
  esac
  ;;

esac
