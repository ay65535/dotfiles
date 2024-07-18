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
  #alias brew="$HOMEBREW_PREFIX/bin/brew"

  alias c=cask
  alias b=brew

  alias cask='brew cask '
  alias caski='cask info'
  alias caskI='cask install'
  alias brews='brew search'
  alias brewu='brew update'
  alias bupd='brew update'
  alias brewU='brew upgrade'
  alias bupg='brew upgrade'
  alias brewl='brew list'
  alias bls='brew list'
  alias brewi='brew info'
  alias brewI='brew install'
  alias binst='brew install'
  alias brewcl='brew cask list'
  alias brewci='brew cask info'
fi
