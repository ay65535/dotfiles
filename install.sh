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


#
# Main
#

shopt -s extglob

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

git config --list --global
git config --list --show-origin

# setup bash_completion
if [[ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions" ]]; then
  mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions"
fi

# homebrew
local/share/installers/homebrew/install_homebrew.sh

#
# dotter
#

brew install dotter

# execute dotter
cd ~/.dotfiles
mv ~/.dotfiles/.dotter/global.toml{,.bak}
dotter init
mv ~/.dotfiles/.dotter/global.toml{.bak,}

# edit local.toml
sed -i -e "s@includes = \[\]@includes = [\".dotter/${OSDIR}.toml\"]@" ~/.dotfiles/.dotter/local.toml
sed -i -e 's@packages = \["default"\]@packages = ["default", "dotfiles"]@' ~/.dotfiles/.dotter/local.toml
cat ~/.dotfiles/.dotter/local.toml

dotter deploy -d
if [ -f ~/.bash_aliases ]; then
  cat ~/.bash_aliases
  mv ~/.bash_aliases{,.bak}
fi
if [ -d ~/.config ]; then
  ls ~/.config
  mv ~/.config{,.bak}
fi
if [ -d ~/.ssh ]; then
  ls ~/.ssh
  mv ~/.ssh{,.bak}
fi
dotter deploy
mv ~/.config.bak/* ~/.config/ && rmdir ~/.config.bak
mv ~/.ssh.bak/* ~/.ssh/ && rmdir ~/.ssh.bak
ls -la ~
# dotter undeploy -d
# dotter undeploy -y  # not work on windows..

#
# mise
#

#export MISE_CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/mise/${OSDIR:?}
export MISE_CONFIG_DIR=${SCRIPT_ROOT:?}/.config/mise/${OSDIR:?}
echo $MISE_CONFIG_DIR
local/share/installers/mise/install_mise-apt.sh
eval "$(mise activate ${SHELL##*/})"
#eval "$(mise completion ${SHELL##*/})"
echo $PATH | tr : '\n'
# sudo mise self-update
mise plugins update
mise outdated
mise list --global
mise reshim
mise doctor

sudo apt -y install build-essential
mise use --global rust

# cargo-binstall deps
#wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb && \
#  sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
#mise use --global cargo-binstall

# mise use --global cargo:dotter

#
# sheldon
#

sudo apt -y install pkg-config libssl-dev # sheldon deps
apt list libssl*
mise use --global cargo:sheldon

mise upgrade --bump # upgrade all new versions
