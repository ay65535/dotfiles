#!/usr/bin/env bash

# code --help
# code update

# shellcheck disable=SC1090
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  VSCODE_REMOTE_CLI=$(command -v "${VSCODE_GIT_ASKPASS_NODE%/node}"/bin/remote-cli/code*)
  if [ -n "$VSCODE_REMOTE_CLI" ]; then
    . "$($VSCODE_REMOTE_CLI --locate-shell-integration-path bash)"
  fi
fi
