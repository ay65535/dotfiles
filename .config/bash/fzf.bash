if [ -d /usr/local/opt/fzf/bin ]; then
  # Setup fzf
  # ---------
  if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
    export PATH="$PATH:/usr/local/opt/fzf/bin"
  fi

  # Auto-completion
  # ---------------
  # shellcheck source=/usr/local/opt/fzf/shell/completion.bash
  [[ $- == *i* ]] && source /usr/local/opt/fzf/shell/completion.bash 2>/dev/null

  # Key bindings
  # ------------
  # shellcheck source=/usr/local/opt/fzf/shell/key-bindings.bash
  source /usr/local/opt/fzf/shell/key-bindings.bash
fi
