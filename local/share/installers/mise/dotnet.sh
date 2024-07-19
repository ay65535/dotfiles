#!/usr/bin/env bash

mise plugins ls-remote | grep dotnet

# dotnet-sdk-8.0/noble-updates,noble-security 8.0.107-0ubuntu1~24.04.1 amd64
# apt list dotnet*

# 8.0.303
mise ls-remote dotnet

# deps
#sudo apt -y install

mise install dotnet
mise use dotnet

apt list --installed dotnet*
mise ls

which -a dotnet
dotnet --version
