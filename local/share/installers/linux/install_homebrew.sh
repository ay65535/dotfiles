#!/bin/bash

# https://brew.sh/
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Homebrew's dependencies if you have sudo access:
sudo apt-get install build-essential

# We recommend that you install GCC:
brew install gcc

# ----------

# # https://docs.brew.sh/Installation.html#untar-anywhere-unsupported

# mkdir ~/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/homebrew
# # or:
# #git -C ~ clone https://github.com/Homebrew/brew homebrew

# # then:
# eval "$(homebrew/bin/brew shellenv)"
# brew update --force --quiet
# chmod -R go-w "$(brew --prefix)/share/zsh"
