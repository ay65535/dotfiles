#!/bin/bash

export SHELDON_CONFIG_DIR=${XDG_CONFIG_HOME:-${HOME}/.config}/sheldon/${SHELL##*/}
eval "$(sheldon source)"
