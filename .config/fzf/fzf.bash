FZF_ROOT="$HOME/.local/src/github.com/junegunn/fzf"

if [ ! -f "$FZF_ROOT/bin/fzf" ]; then
  return
fi

# Setup fzf
# ---------
if [[ ! "$PATH" == *$FZF_ROOT/bin* ]]; then
  PATH="${PATH:+${PATH}:}$FZF_ROOT/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_ROOT/shell/completion.bash" 2>/dev/null

# Key bindings
# ------------
source "$FZF_ROOT/shell/key-bindings.bash"
