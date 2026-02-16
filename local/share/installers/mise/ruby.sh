#!/usr/bin/env bash

mise plugins ls-remote | grep ruby
mise plugins ls --core | grep ruby

mise ls-remote ruby 3
# https://github.com/rbenv/ruby-build/wiki#ubuntudebianmint
sudo apt -y install build-essential autoconf libssl-dev libyaml-dev zlib1g-dev libffi-dev libgmp-dev rustc
# sudo apt -y install patch libreadline6-dev libncurses5-dev libgdbm6 libgdbm-dev libdb-dev
# sudo apt -y uuid-dev
mise use -g ruby@3
mise ls
mise ls -g

which -a ruby
ruby -v
/usr/bin/ruby -v
