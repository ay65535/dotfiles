#!/usr/bin/env bash

# apt list *sheldon*
# mise plugins ls-remote | grep sheldon

# ==> sheldon: stable 0.7.4 (bottled), HEAD
brew info sheldon

# sudo apt -y install sheldon
# apt list --installed sheldon
# mise install sheldon
# mise use sheldon
brew install sheldon

which -a sheldon
sheldon --version
