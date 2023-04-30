#!/bin/bash

alias q=exit
alias sudo='sudo '

# source ~/.config/bash/*.*sh if it exists.
shopt -s extglob
if globexists "$XDG_CONFIG_HOME"/bash/*.*(ba)sh; then
  for f in "$XDG_CONFIG_HOME"/bash/*.*(ba)sh; do
    # shellcheck source=.config/bash/bash_aliases.bash source=.config/bash/bash_functions.bash source=.config/bash/bash_session_history.bash source=.config/bash/bashrc.bash source=.config/bash/fzf.bash
    . "$f"
  done
fi
