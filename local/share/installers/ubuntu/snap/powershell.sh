#!/bin/bash
# https://learn.microsoft.com/ja-jp/powershell/scripting/install/install-other-linux?view=powershell-7.4#snap-package
# Snap パッケージ

export POWERSHELL_TELEMETRY_OPTOUT=1

snap find powershell

# Install PowerShell
sudo snap install powershell --classic

# Start PowerShell
# pwsh

# Uninstall
# sudo snap remove powershell
