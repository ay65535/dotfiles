#!/usr/bin/env bash

mise plugins ls-remote | grep go
mise plugins ls

mise ls-remote go
mise install go 1.22
mise use --global go

apt list --installed go*
mise ls

which -a go
go version
