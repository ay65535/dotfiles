#!/bin/sh

# https://wiki.archlinux.jp/index.php/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# export WGETRC="$XDG_CONFIG_HOME/wgetrc"
# alias wget=wget --hsts-file='$XDG_CACHE_HOME/wget-hsts'

# shellcheck disable=SC2016
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages

# export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
# export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
# export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle

export NVM_DIR="$XDG_DATA_HOME"/nvm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"
# alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'

# export GOPATH="$XDG_DATA_HOME"/go

# export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
# export CARGO_HOME="$XDG_DATA_HOME"/cargo

export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv

# export FFMPEG_DATADIR="$XDG_CONFIG_HOME"/ffmpeg

# export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant
# export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME"/vagrant/aliases
