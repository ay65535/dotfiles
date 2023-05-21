#!/bin/bash
# https://docs.brew.sh/Homebrew-on-Linux

# deps
sudo apt-get -y install build-essential procps curl file git

if [[ "$(uname -m)" == "aarch64" ]]; then
  # ATTENTION: may not work!

  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o homebrew_install.sh
  # patch
  perl -i -0pe 's/abort "\$\(\n\s*cat <<EOABORT\nHomebrew on Linux is not supported on ARM processors\.\n\s*.*[\s\S]*?\nEOABORT\n\s*\)"/: # do nothing/m' homebrew_install.sh

  # install deps
  git -C "$(rbenv root)" pull --rebase
  git -C "$(rbenv root)/plugins/ruby-build" pull --rebase
  rbenv install -L | grep -q 2.6.10 || reuturn 1
  rbenv install 2.6.10
  rbenv global 2.6.10
  rbenv global
  ruby -v

  # set env
  # https://github.com/orgs/Homebrew/discussions/3612#discussioncomment-3572967
  export HOMEBREW_DEVELOPER=1
  export HOMEBREW_USE_RUBY_FROM_PATH=1
  HOMEBREW_RUBY_PATH=$(command -v ruby)
  export HOMEBREW_RUBY_PATH

  # install
  sudo rm -rf /home/linuxbrew/
  chmod +x homebrew_install.sh
  /bin/bash homebrew_install.sh
  sudo env | grep -i brew
  sudo -E env | grep -i brew
  sudo -E /bin/bash homebrew_install.sh
  rm -i homebrew_install.sh
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
