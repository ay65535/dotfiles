#!/bin/bash

if [[ -z "$RBENV_ROOT" ]]; then
  export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
fi

#
# rbenv / ruby-build
#

### rbenv
if [[ ! -d "$RBENV_ROOT" ]]; then
  ## Installing
  # https://github.com/rbenv/rbenv#basic-github-checkout
  git clone https://github.com/rbenv/rbenv.git "$RBENV_ROOT"
  cd "$RBENV_ROOT" && src/configure && make -C src
else
  ## Upgrading
  git -C "$RBENV_ROOT" pull
fi

### ruby-build
if [[ ! -d "$RBENV_ROOT"/plugins/ruby-build ]]; then
  ## Installing
  # ruby-build as an rbenv plugin
  mkdir -p "$RBENV_ROOT"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$RBENV_ROOT"/plugins/ruby-build
else
  ## Upgrading
  git -C "$RBENV_ROOT/plugins/ruby-build" pull
fi

. ~/.bash_profile

## Verify
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash

#
# ruby
#

# rbenv install -l
# rbenv install -L
# rbenv install -L | grep 2.6.8
LATEST_VERSION=$(rbenv install --list 2>/dev/null | grep -P '^\d+\.\d+\.\d+' | tail -1)
# TARGET_VERSION=2.6.8  # for linuxbrew
TARGET_VERSION=$LATEST_VERSION

# get libgdbm package name
LIBGDBM=$(apt list libgdbm* 2>/dev/null | grep -oP '^libgdbm\d')
# https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
sudo apt-get -y install autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev "$LIBGDBM" libgdbm-dev libdb-dev uuid-dev

rbenv install "$TARGET_VERSION"
rbenv versions
rbenv global "$TARGET_VERSION"
rbenv global
ruby -v
unset TARGET_VERSION
