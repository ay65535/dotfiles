FZF_PATH=$(command -v fzf)
if [[ "$FZF_PATH" == */bin/fzf ]]; then
  FZF_BASE=${FZF_PATH%/bin/fzf}
elif [[ "$FZF_PATH" == *zinit/plugins/*/fzf ]]; then
  FZF_BASE=${FZF_PATH%/fzf}
elif [[ -d "$HOME/.local/src/github.com/junegunn/fzf" ]]; then
  FZF_BASE="$HOME/.local/src/github.com/junegunn/fzf"
else
  return
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
