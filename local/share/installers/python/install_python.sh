#!/usr/bin/env bash

# apt list --installed python3.*
# python3.11/stable,now 3.11.2-6+deb12u5 arm64 [installed,automatic]

# brew search python
# python@3.12
# python@3.13
# brew info python
# ==> python@3.13: stable 3.13.3 (bottled)

mise plugins ls-remote | grep python
mise registry | grep python
mise plugins ls --core | grep python
mise ls-remote python
# 3.13.3
mise install python
mise use --global python

which -a python
python --version

which -a python3
python3 --version
/usr/bin/python3 --version
