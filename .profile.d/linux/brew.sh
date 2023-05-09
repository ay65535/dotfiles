#!/bin/bash

# eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
eval_brew_shellenv() {
  HOMEBREW_PREFIX=${1:-${HOMEBREW_PREFIX:-/home/linuxbrew/.linuxbrew}}

  if [ -r "$HOMEBREW_PREFIX/bin/brew" ]; then
    export HOMEBREW_PREFIX
    export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
    export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin${PATH+:$PATH}"
    export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:"
    export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"
    true
  fi

  false
}

eval_brew_shellenv /home/linuxbrew/.linuxbrew || \
eval_brew_shellenv "$HOME/homebrew"

if command -v brew >/dev/null; then
  export HOMEBREW_CURLRC=${XDG_CONFIG_HOME:-$HOME/.config}/.curlrc
  export HOMEBREW_TEMP=$HOME/.tmp
  if [ ! -d "$HOMEBREW_TEMP" ]; then
    mkdir -p "$HOMEBREW_TEMP"
  fi
fi
