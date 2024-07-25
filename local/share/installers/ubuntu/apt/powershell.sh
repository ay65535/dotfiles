#!/bin/bash

# https://learn.microsoft.com/ja-jp/powershell/scripting/install/install-ubuntu?view=powershell-7.4#installation-via-package-repository-the-package-repository
# パッケージ リポジトリによるパッケージ リポジトリのインストール

export POWERSHELL_TELEMETRY_OPTOUT=1

INSTALL_OPTION=${1:-repo}

if [ "$INSTALL_OPTION" = repo ]; then

  ###################################
  # Prerequisites

  # Update the list of packages
  sudo apt-get update

  # Install pre-requisite packages.
  sudo apt-get install -y wget apt-transport-https software-properties-common

  # Get the version of Ubuntu
  source /etc/os-release

  # Download the Microsoft repository keys
  wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

  # Register the Microsoft repository keys
  sudo dpkg -i packages-microsoft-prod.deb

  # Delete the Microsoft repository keys file
  rm packages-microsoft-prod.deb

  # Update the list of packages after we added packages.microsoft.com
  sudo apt-get update

  apt search powershell
  apt list powershell*
  apt show powershell

  ###################################
  # Install PowerShell
  sudo apt-get install -y powershell

  # Start PowerShell
  #pwsh

elif [ "$INSTALL_OPTION" = deb ]; then
  # https://learn.microsoft.com/ja-jp/powershell/scripting/install/install-ubuntu?view=powershell-7.4#installation-via-direct-download
  # 直接ダウンロードによるインストール

  # VERSION=7.5.0-preview.2-1
  VERSION=7.4.4-1
  # VERSION=7.3.12-1
  # VERSION=7.2.19-1

  if [[ $VERSION =~ preview ]]; then
    PREVIEW=-preview
  else
    PREVIEW=
  fi

  ###################################
  # Prerequisites

  # Update the list of packages
  sudo apt-get update

  # Install pre-requisite packages.
  sudo apt-get install -y wget

  # Download the PowerShell package file
  wget https://github.com/PowerShell/PowerShell/releases/download/v${VERSION%-*}/powershell${PREVIEW}_${VERSION}.deb_amd64.deb

  ###################################
  # Install the PowerShell package
    sudo dpkg -i powershell${PREVIEW}_${VERSION}.deb_amd64.deb

  # Resolve missing dependencies and finish the install (if necessary)
  sudo apt-get install -f

  # Delete the downloaded package file
  rm powershell${PREVIEW}_${VERSION}.deb_amd64.deb

  # Start PowerShell Preview
  # pwsh-lts
else

  cat <<EOF >&2
usage: ${0##*/} [repo|deb]
       repo: パッケージリポジトリによるインストール
       deb : .deb ファイルを直接ダウンロードしてインストール
EOF

fi
