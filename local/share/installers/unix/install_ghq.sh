#!/bin/sh
go install github.com/x-motemen/ghq@latest

if git config --get-all ghq.root >/dev/null 2>&1; then
  echo "ghq.root is already set: $(git config --get-all ghq.root)"
else
  git config --global ghq.root ~/.local/src
fi
