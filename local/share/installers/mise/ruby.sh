#!/usr/bin/env bash

mise plugins ls-remote | grep ruby
mise plugins ls

mise ls-remote ruby 3
mise install ruby 3
mise ls

ruby -v
