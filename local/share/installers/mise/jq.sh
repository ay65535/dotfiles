#!/usr/bin/env bash

mise plugins ls-remote | grep jq

# jq/noble,noble 1.7.1-3build1 amd64
# apt list jq

# 1.7.1
mise ls-remote jq

sudo apt -y install jq

which -a jq
jq --version
