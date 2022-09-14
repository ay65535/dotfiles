#!/bin/bash

alias q=exit
alias sudo='sudo '
alias d=docker
alias dc='docker container'
alias dcl='docker container list'
alias di='docker image'
alias dil='docker image list'
alias dv='docker volume'
alias dvl='docker volume list'
alias dC=docker-compose

export HISTFILE="$XDG_STATE_HOME"/bash/history
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion
