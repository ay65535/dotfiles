#!/bin/bash

check_brew_shellenv() {
  local homebrew_prefix_tmp=${1:-$HOMEBREW_PREFIX}
  if [ "$HOMEBREW_SHELLENV_DID_INIT" = true ]; then
    return 0
  elif [ -n "$HOMEBREW_PREFIX" ] && [ "$HOMEBREW_PREFIX" = "$homebrew_prefix_tmp" ] &&
    [ -n "$HOMEBREW_CELLAR" ] && [ "$HOMEBREW_CELLAR" = "$HOMEBREW_PREFIX/Cellar" ] &&
    [ -n "$HOMEBREW_REPOSITORY" ] && [ "$HOMEBREW_REPOSITORY" = "$HOMEBREW_PREFIX" ] &&
    echo "$PATH" | grep "$HOMEBREW_PREFIX/bin"; then
    HOMEBREW_SHELLENV_DID_INIT=true
    return 0
  else
    HOMEBREW_SHELLENV_DID_INIT=false
    return 1
  fi
}

# eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
# eval "$($HOMEBREW_PREFIX/bin/brew shellenv zsh)"
eval_brew_shellenv() {
  # find homebrew root directory
  local homebrew_prefix_tmp=${1:-$HOMEBREW_PREFIX}

  if check_brew_shellenv "$homebrew_prefix_tmp"; then
    return 0
  else
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

    if [ -r "$HOMEBREW_PREFIX/bin/brew" ]; then
      export HOMEBREW_PREFIX
      export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
      export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
      export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin${PATH+:$PATH}"
      export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH:+:$MANPATH}"
      export INFOPATH="$HOMEBREW_PREFIX/share/info${INFOPATH:+:$INFOPATH}"
      HOMEBREW_SHELLENV_DID_INIT=true
      return 0
    fi
  fi

  return 1
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
