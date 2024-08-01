#!/usr/bin/env bash

mise plugins ls-remote | grep rust
mise plugins ls

# rust-all/noble 1.75.0+dfsg0ubuntu1-0ubuntu7 all
apt list rust-all

# 1.80.0
mise ls-remote rust
mise install rust
mise use --global rust

apt list --installed rust*
mise ls

eval "$(mise activate bash)"
which -a rustc
rustc --version
which -a cargo
cargo --version
