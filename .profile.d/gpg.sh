#!/bin/bash

[ -f "$HOME/.gnupg/pubring.kbx" ] && GPG_TTY=$(tty) && export GPG_TTY
