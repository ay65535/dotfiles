#!/bin/bash

if [ -r "$HOMEBREW_PREFIX/opt/dotnet/libexec" ]; then
  export DOTNET_ROOT="$HOMEBREW_PREFIX/opt/dotnet/libexec"
  PATH=$(add_path_after "$PATH" "${DOTNET_ROOT%/libexec}/bin")
  [ -d "${DOTNET_ROOT%/libexec}/tools" ] && PATH=$(add_path_after "$PATH" "${DOTNET_ROOT%/libexec}/tools")
  export PATH
elif [ -r "$HOMEBREW_PREFIX/opt/dotnet@6/libexec" ]; then
  export DOTNET_ROOT="$HOMEBREW_PREFIX/opt/dotnet@6/libexec"
  PATH=$(add_path_after "$PATH" "${DOTNET_ROOT%/libexec}/bin")
  [ -d "${DOTNET_ROOT%/libexec}/tools" ] && PATH=$(add_path_after "$PATH" "${DOTNET_ROOT%/libexec}/tools")
  export PATH
elif [ -r "$HOME/.dotnet" ]; then
  export DOTNET_ROOT="$HOME/.dotnet"
  PATH=$(add_path_after "$PATH" "$DOTNET_ROOT")
  [ -d "$DOTNET_ROOT/tools" ] && PATH=$(add_path_after "$PATH" "$DOTNET_ROOT/tools")
  export PATH
fi

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export POWERSHELL_TELEMETRY_OPTOUT=1
