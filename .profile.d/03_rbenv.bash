#!/bin/bash

if [ "$RBENV_DID_INIT" ]; then
  return
fi

rbenv_paths=("${XDG_DATA_HOME:-$HOME}/rbenv" "$HOME/.rbenv")
# echo "${rbenv_paths[@]}"
for p in "${rbenv_paths[@]}"; do
  if [ -d "$p" ]; then
    rbenv_path=$p
    break
  fi
done

if [ "$rbenv_path" = "" ]; then
  export RBENV_DID_INIT=1
  return
fi

export RBENV_ROOT="$rbenv_path"

# eval "$(rbenv init - bash)" {{
export PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:${PATH}"
export RBENV_SHELL=bash
source "$RBENV_ROOT/completions/rbenv.bash"
# shellcheck disable=SC2218
command rbenv rehash 2>/dev/null
rbenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash | shell)
    eval "$(rbenv "sh-$command" "$@")"
    ;;
  *)
    command rbenv "$command" "$@"
    ;;
  esac
}
# }}

export RBENV_DID_INIT=1
