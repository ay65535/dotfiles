#!/bin/bash

if command -v brew >/dev/null; then
  export HOMEBREW_CURLRC=${XDG_CONFIG_HOME:-$HOME/.config}/.curlrc
  export HOMEBREW_TEMP=$HOME/.tmp
  if [ ! -d "$HOMEBREW_TEMP" ]; then
    mkdir -p "$HOMEBREW_TEMP"
  fi
fi
