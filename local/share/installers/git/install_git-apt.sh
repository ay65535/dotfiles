#!/bin/bash

sudo apt update
apt list git
# git/stable,stable-security 1:2.39.5-0+deb12u2 arm64

sudo apt -y install git

which -a git
git --version
