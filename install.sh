#!/bin/bash

set -eu

#
# Script Variables
#

# SCRIPT_ROOT=$HOME/.dotfiles
SCRIPT_ROOT="$(cd "$(dirname "$0")" && pwd)"

#
# Functions
#

symlink_to_home() {
  # 1st param is: filename to symlink
  local link_name="$1"
  local link_dir="$HOME"
  local link_path="$link_dir/$link_name"
  local orig_fullpath="$SCRIPT_ROOT/$link_name"

  # check original file existence
  if [[ ! -e "$orig_fullpath" ]]; then
    echo "$orig_fullpath is not found, do nothing." >&2
    return
  fi

  # check symlink existence
  if [[ -e "$link_path" ]]; then
    echo "$link_path is already exists, do nothing." >&2
    return
  fi

  # get relative path
  local orig_relpath
  orig_relpath="$(realpath --relative-to="$link_dir" "$orig_fullpath")"

  ln -snfv "$orig_relpath" "$link_path"
}

#
# Main
#

shopt -s extglob

TARGET=("$SCRIPT_ROOT"/@(.!(git|.|)|bin|local))

for f in "${TARGET[@]}"; do
  symlink_to_home "$(basename "$f")"
done

# if .bashrc not found, create it
if [ ! -f ~/.bashrc ] || ! grep -q .bash_aliases ~/.bashrc; then
  echo '. ~/.bash_aliases' >~/.bashrc
fi

# check os
case "$OSTYPE" in
"linux"*) OSDIR=linux ;;
"darwin"*) OSDIR=macos ;;
"msys"*) OSDIR=windows ;;
*) OSDIR=unknown ;;
esac

# setup .gitconfig

if ! git config --get-all include.path; then
  if [ ! -f "$HOME/.gitconfig" ]; then
    git config --file "$SCRIPT_ROOT/.config/git/config" --add include.path "$SCRIPT_ROOT/.config/git/config.core"

    git config --get-all include.path | grep -q $OSDIR/config
    if [[ "$?" == "1" ]] && [[ "$OSDIR" != 'unknown' ]]; then
      git config --file "$SCRIPT_ROOT/.config/git/config" --add include.path "$SCRIPT_ROOT/.config/git/$OSDIR/config"
    fi

  else
    git config --global --add include.path ~/.config/git/config.core

    git config --get-all include.path | grep -q $OSDIR/config
    if [[ "$?" == "1" ]] && [[ "$OSDIR" != 'unknown' ]]; then
      git config --global --add include.path ~/.config/git/$OSDIR/config
    fi

    if [ -f "$SCRIPT_ROOT/.config/git/config" ]; then
      echo "both ~/.gitconfig and ~/.config/git/config exists."
    fi
  fi
fi

# setup bash_completion
if [[ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions" ]]; then
  mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions"
fi

cd ~
ln -snfv .dotfiles/secret/.secret .
ln -snfv .dotfiles/secret/.ssh .
# cd ~/.ssh
# chmod 750 .
