#!/usr/bin/env bash

sudo apt update
apt search rbenv
apt list rbenv
apt show rbenv
sudo apt -y install rbenv

which -a rbenv
rbenv versions
ruby -v
rbenv install -l | grep -E '^(2.7|3.)'
# too old..

sudo apt -y purge rbenv
sudo apt -y autoremove
