#!/bin/bash
# https://askubuntu.com/a/310

NAME=ppa:whatever/ppa
# NAME=ppa:git-core/ppa
# NAME=ppa:git-core/candidate

# Use the --remove flag, similar to how the PPA was added:
# sudo add-apt-repository --remove $NAME

# You can also remove PPAs by deleting the .list files from /etc/apt/sources.list.d directory.
# ls -la /etc/apt/sources.list.d
# cat /etc/apt/sources.list.d/git-core-ubuntu-candidate-noble.sources
# sudo rm /etc/apt/sources.list.d/git-core-ubuntu-candidate-noble.sources

# As a safer alternative, you can install ppa-purge:
sudo apt -y install ppa-purge

# And then remove the PPA, downgrading gracefully packages it provided to packages provided by official repositories:
# sudo ppa-purge $NAME

# sudo apt -y purge git
