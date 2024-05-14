#!/usr/bin/env bash
# https://github.com/rbenv/rbenv?tab=readme-ov-file#basic-git-checkout

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
~/.rbenv/bin/rbenv init - bash
# export PATH="/home/vscode/.rbenv/bin:${PATH}"
# export PATH="/home/vscode/.rbenv/shims:${PATH}"
# export RBENV_SHELL=bash
# source '/home/vscode/.rbenv/completions/rbenv.bash'
# command rbenv rehash 2>/dev/null
# rbenv() {
#   local command
#   command="${1:-}"
#   if [ "$#" -gt 0 ]; then
#     shift
#   fi
#
#   case "$command" in
#   rehash|shell)
#     eval "$(rbenv "sh-$command" "$@")";;
#   *)
#     command rbenv "$command" "$@";;
#   esac
# }

rbenv install -l
