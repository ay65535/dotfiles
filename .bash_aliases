#!/bin/bash

alias q=exit
alias sudo='sudo '

# source ~/.config/bash/*.*sh if it exists.
if globexists "$XDG_CONFIG_HOME"/bash/*.*(ba)sh; then
  for f in "$XDG_CONFIG_HOME"/bash/*.*(ba)sh; do
    . "$f"
  done
fi
