if [[ -d "$XDG_DATA_HOME/rbenv" ]]; then
  export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
elif [[ -d "$HOME/.rbenv" ]]; then
  export RBENV_ROOT="$HOME/.rbenv"
else
  return
fi

# eval "$(rbenv init - bash)" {{
export PATH="$RBENV_ROOT/shims:${PATH}"
export RBENV_SHELL=bash
source "$RBENV_ROOT/completions/rbenv.bash"
command rbenv rehash 2>/dev/null
rbenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}
# }}
