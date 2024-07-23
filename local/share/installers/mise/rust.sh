#!/usr/bin/env bash

mise plugins ls-remote | grep rust
mise plugins ls

mise ls-remote rust
mise install rust
mise use --global rust

apt list --installed rust*
mise ls

eval "$(mise activate bash)"
which -a rustc
rustc --version
