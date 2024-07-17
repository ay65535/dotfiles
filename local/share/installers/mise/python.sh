#!/usr/bin/env bash

mise plugins ls-remote | grep python
mise plugins ls

mise ls-remote python
mise install python 3.12
mise use python

apt list --installed python3.12*
mise ls

which -a python
python --version

which -a python3
python3 --version
