#!/usr/bin/env bash

mise plugins ls-remote | grep python
mise plugins ls --core | grep python
mise plugins ls

mise ls-remote python
mise install python
mise use --global python

apt list --installed python3.12*
mise ls

which -a python
python --version

which -a python3
python3 --version
/usr/bin/python3 --version
