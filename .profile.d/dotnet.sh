#!/bin/bash

# if [ -r "$HOMEBREW_PREFIX/opt/dotnet/libexec" ]; then
#   export DOTNET_ROOT="$HOMEBREW_PREFIX/opt/dotnet/libexec"
#   PATH=$(add_path_after "$PATH" "${DOTNET_ROOT%/libexec}/bin")
#   [ -d "${DOTNET_ROOT%/libexec}/tools" ] && PATH=$(add_path_after "$PATH" "${DOTNET_ROOT%/libexec}/tools")
#   export PATH
# elif [ -r "$HOME/.dotnet" ]; then
#   export DOTNET_ROOT="$HOME/.dotnet"
#   PATH=$(add_path_after "$PATH" "$DOTNET_ROOT")
#   [ -d "$DOTNET_ROOT/tools" ] && PATH=$(add_path_after "$PATH" "$DOTNET_ROOT/tools")
#   export PATH
# fi

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=1
export POWERSHELL_TELEMETRY_OPTOUT=1

if [ -d "$HOME/.dotnet/tools" ] && ! (echo "$PATH" | grep -q "$HOME/.dotnet/tools"); then
  export PATH="$HOME/.dotnet/tools:$PATH"
fi
