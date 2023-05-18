if [ ! -d "$XDG_STATE_HOME"/bash ]; then
  mkdir -p "$XDG_STATE_HOME"/bash
fi
export EDITOR=vi
export HISTFILE="$XDG_STATE_HOME/bash/history"

#
# completions
#

export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME/bash_completion"

[[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]] && . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"

# kubectl
if command -v kubectl >/dev/null; then
  if [[ ! -r "$XDG_CONFIG_HOME/bash-completion.d/kubectl_completion.bash" ]]; then
    mkdir -p "$XDG_CONFIG_HOME/bash-completion.d"
    kubectl completion bash >"$XDG_CONFIG_HOME/bash-completion.d/kubectl_completion.bash"
  fi
  . "$XDG_CONFIG_HOME/bash-completion.d/kubectl_completion.bash"
fi

if [ -n "$http_proxy" ]; then
  echo "proxy=$http_proxy" >"$HOME/curlrc"
else
  test -f "$HOME/curlrc" && rm "$HOME/curlrc"
fi

# shellcheck source=/home/jetson/.config/fzf/fzf.bash
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
