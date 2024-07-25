#!/bin/sh

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

if [ -n "$HOMEBREW_PREFIX" ]; then
  alias brews='brew search'
  alias brewu='brew update'
  alias brewU='brew upgrade'
  alias brewl='brew list'
  alias brewi='brew info'
  alias brewI='brew install'
fi
