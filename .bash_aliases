#!/bin/bash

alias q=exit
alias sudo='sudo '

if [ -n "$BASH" ]; then
  SHEXT_PREFIX=ba
  shopt -s extglob
elif [ -n "$ZSH_NAME" ]; then
  SHEXT_PREFIX=z
  setopt EXTENDED_GLOB
fi

# source ~/.config/bash/*.*sh if it exists.
if globexists "$XDG_CONFIG_HOME"/bash/*.*("$SHEXT_PREFIX")sh; then
  for f in "$XDG_CONFIG_HOME"/bash/*.*("$SHEXT_PREFIX")sh; do
    # shellcheck source=.config/bash/bash_aliases.bash source=.config/bash/bash_functions.bash source=.config/bash/bash_session_history.bash source=.config/bash/bashrc.bash source=.config/bash/fzf.bash
    . "$f"
  done
fi
