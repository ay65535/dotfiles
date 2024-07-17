#!/usr/bin/env bash
# https://github.com/rbenv/rbenv?tab=readme-ov-file#basic-git-checkout

# rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# ~/.rbenv/bin/rbenv init - bash
rbenv rehash

# https://github.com/rbenv/ruby-build/wiki#ubuntudebianmint
sudo apt -y install autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev

# ruby-build
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

latest_version=$(rbenv install -l | grep -E '^[1-9]\.' | tail -1)
rbenv install "$latest_version"

# upgrade
# git -C "$(rbenv root)" pull --rebase
# git -C "$(rbenv root)"/plugins/ruby-build pull --rebase
