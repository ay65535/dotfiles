#!/usr/bin/env bash

mise plugins ls-remote | grep rust
mise plugins ls

# rust-all/jammy-updates,jammy-security 1.75.0+dfsg0ubuntu1~bpo0-0ubuntu0.22.04 all
# rust-all/noble 1.75.0+dfsg0ubuntu1-0ubuntu7 all
apt list rust-all
# cargo/jammy-updates,jammy-security 1.75.0+dfsg0ubuntu1~bpo0-0ubuntu0.22.04 amd64
apt list cargo
# sudo apt -y install cargo

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

# warning: be sure to add `~/.cargo/bin` to your PATH to be able to run the installed binaries

# mise uninstall --all rust && mise plugins uninstall --purge rust # uninstall
# mise reshim
# mise doctor
