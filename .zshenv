#!/bin/zsh

# setopt no_global_rcs

## Functions
globexists () {
  # https://stackoverflow.com/questions/41502846/zsh-test-whether-a-file-matching-a-pattern-exists
  [[ -n *$1*(#qN) ]]
}

## Main

# source ~/.profile.d/*.sh if it exists.
setopt extendedglob
unsetopt nomatch
local -a files
files=($(find -E ~/.profile.d/*.*sh -regex '.*\.z?sh$'))
for file in $files; do
  . "$file"
done
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
