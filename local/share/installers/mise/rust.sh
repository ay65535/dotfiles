#!/usr/bin/env bash

mise plugins ls-remote | grep rust
mise plugins ls

mise ls-remote rust
mise install rust 1.79
mise use rust

apt list --installed rust*
mise ls

eval "$(mise activate bash)"
which -a rustc
rustc --version
