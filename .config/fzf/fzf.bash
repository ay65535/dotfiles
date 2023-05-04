FZF_PATH=$(command -v fzf)
if [ -n "$FZF_PATH" ]; then
  FZF_BASE=${FZF_PATH%/fzf}
else
  FZF_BASE="$HOME/.local/src/github.com/junegunn/fzf"
  if [ ! -f "$FZF_BASE/bin/fzf" ]; then
    return
  fi
fi

# Setup fzf
# ---------
if [[ ! "$PATH" == *$FZF_BASE/bin* ]]; then
  PATH="${PATH:+${PATH}:}$FZF_BASE/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_BASE/shell/completion.bash" 2>/dev/null

# Key bindings
# ------------
source "$FZF_BASE/shell/key-bindings.bash"
