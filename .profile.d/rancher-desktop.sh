#!/bin/bash

if [ -d "$HOME/.rd/bin" ]; then
  export PATH="$HOME/.rd/bin:$PATH"
else
  return
fi
