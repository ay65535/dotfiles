#!/usr/bin/env bash

# apt list dotnet*
# dotnet-sdk-8.0/noble-updates,noble-security 8.0.107-0ubuntu1~24.04.1 amd64
# apt list --installed dotnet*

# brew search dotnet
# dotnet@8
# dotnet@9
# brew info dotnet
# ==> dotnet: stable 9.0.4 (bottled), HEAD

mise plugins ls-remote | grep dotnet
mise ls-remote dotnet
# 8.0.408
# 9.0.203
mise install dotnet@8
mise use --global dotnet@8

which -a dotnet
dotnet --version
