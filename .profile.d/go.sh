#!/bin/sh

if [ -d /usr/local/go ]; then
  export GOROOT=/usr/local/go
  # export GOPATH="$HOME/go"
  export GOPATH="$HOME/.local"
  export GOBIN="$GOPATH/bin"
  export PATH="$PATH:/usr/local/go/bin:$GOBIN"
fi
