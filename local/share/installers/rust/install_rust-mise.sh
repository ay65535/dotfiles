#!/usr/bin/env bash

# apt list rustup
# -
# apt list rust-all
# rust-all/stable 1.63.0+dfsg1-2+rpi1 all
# rust-all/jammy-updates,jammy-security 1.75.0+dfsg0ubuntu1~bpo0-0ubuntu0.22.04 all
# rust-all/noble 1.75.0+dfsg0ubuntu1-0ubuntu7 all
# apt list cargo
# cargo/stable 0.66.0+ds1-1 arm64
# cargo/jammy-updates,jammy-security 1.75.0+dfsg0ubuntu1~bpo0-0ubuntu0.22.04 amd64
# sudo apt -y install cargo
# apt list --installed rust*

brew info rustup
# ==> rustup: stable 1.28.1 (bottled), HEAD [keg-only]
# brew info rust
# ==> rust: stable 1.86.0 (bottled), HEAD
brew install rustup

# mise plugins ls --core | grep -iE 'rust|cargo'
# mise plugins ls-remote | grep -iE 'rust|cargo'
# mise ls-remote rust
# 1.86.0
# mise install rust
# mise use --global rust
# mise ls

# eval "$(mise activate bash)"
which -a rustc
rustc --version
which -a cargo
cargo --version

# warning: be sure to add `~/.cargo/bin` to your PATH to be able to run the installed binaries

# mise uninstall --all rust && mise plugins uninstall --purge rust # uninstall
# mise reshim
# mise doctor
