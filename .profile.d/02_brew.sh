#!/bin/bash

# eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
# eval "$($HOMEBREW_PREFIX/bin/brew shellenv zsh)"
eval_brew_shellenv() {
  # find homebrew root directory
  HOMEBREW_PREFIX=${1:-$HOMEBREW_PREFIX}
  if [ -z "$HOMEBREW_PREFIX" ]; then
    if macos; then
      UNAME_MACHINE=$(uname -m)
      if [ "$UNAME_MACHINE" = 'arm64' ]; then
        HOMEBREW_PREFIX=/opt/homebrew
      elif [ "$UNAME_MACHINE" = 'x86_64' ]; then
        HOMEBREW_PREFIX=/usr/local
      else
        echo "Unknown machine type: $UNAME_MACHINE" >&2
      fi
    elif linux; then
      HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
    else
      echo "Unknown OS: $OSTYPE" >&2
    fi
  fi

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

# ----------

eval_brew_shellenv /opt/homebrew ||
  eval_brew_shellenv /home/linuxbrew/.linuxbrew ||
  eval_brew_shellenv "$HOME/homebrew"

if command -v brew >/dev/null; then
  export HOMEBREW_CURLRC=${XDG_CONFIG_HOME:-$HOME/.config}/.curlrc
  export HOMEBREW_TEMP=$HOME/.tmp
  if [ ! -d "$HOMEBREW_TEMP" ]; then
    mkdir -p "$HOMEBREW_TEMP"
  fi

  # formulae specific settings
  [ -r "$HOMEBREW_PREFIX/opt/dotnet/libexec" ] && export DOTNET_ROOT="$HOMEBREW_PREFIX/opt/dotnet/libexec"
fi
