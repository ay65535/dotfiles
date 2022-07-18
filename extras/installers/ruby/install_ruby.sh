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

## Verify
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash

#
# ruby
#

LATEST_VERSION=$(rbenv install --list 2>/dev/null | grep -P '^\d+\.\d+\.\d+' | tail -1)
rbenv install $LATEST_VERSION
rbenv versions
rbenv global $LATEST_VERSION
rbenv global
ruby -v
unset LATEST_VERSION
