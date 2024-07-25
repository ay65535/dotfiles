#!/usr/bin/env bash

mise plugins ls-remote | grep ruby
mise plugins ls --core | grep ruby

mise ls-remote ruby 3
sudo apt -y install autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
mise install ruby 3
mise use --global ruby@latest
mise ls

ruby -v
