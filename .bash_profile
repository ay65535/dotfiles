#!/bin/bash

## Options
# shopt -s extglob

## Functions
# globexists() {
#   # https://stackoverflow.com/questions/6363441/check-if-a-file-exists-with-a-wildcard-in-a-shell-script
#   compgen -G "$1" >/dev/null || [ -e "$1" ]
# }
# export -f globexists

## Main

# source ~/.profile.d/*.sh if it exists.
# if globexists ~/.profile.d/*.*(ba)sh; then
#   for f in ~/.profile.d/*.*(ba)sh; do
#     . "$f"
#   done
# fi

# source ~/.profile.d/$OSDIR/*.sh if it exists.
# if globexists ~/.profile.d/$OSDIR/*.*(ba)sh; then
#   for f in ~/.profile.d/$OSDIR/*.*(ba)sh; do
#     . "$f"
#   done
# fi

# export SHELDON_CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/sheldon/${SHELL##*/}
# eval "$(sheldon source)"

# source ~/.profile even when ~/.bash_profile exists.
# shellcheck source=/dev/null
test -f "$HOME/.profile" && . "$HOME/.profile"
