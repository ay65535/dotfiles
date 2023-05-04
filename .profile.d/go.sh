#!/bin/bash

if [ -d /usr/lib/go ]; then
  export GOROOT=/usr/lib/go
elif [ -d /usr/local/go ]; then
  export GOROOT=/usr/local/go
else
  return
fi

#export GOPATH="$HOME/go"
export GOPATH="$HOME/.local"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOROOT/bin:$GOBIN"
