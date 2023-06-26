#!/bin/bash

# https://docs.brew.sh/Installation.html#untar-anywhere-unsupported

mkdir ~/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/homebrew
# or:
#git -C ~ clone https://github.com/Homebrew/brew homebrew

# then:
eval "$(homebrew/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"
