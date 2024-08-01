#!/bin/bash

# mise ls
eval "$(mise activate bash)"
eval "$(mise activate --shims)"

export SHELDON_CONFIG_DIR=${XDG_CONFIG_HOME:-${HOME}/.config}/sheldon/${SHELL##*/}
eval "$(sheldon source)"
