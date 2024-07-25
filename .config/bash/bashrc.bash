if [ ! -d "$XDG_STATE_HOME"/bash ]; then
  mkdir -p "$XDG_STATE_HOME"/bash
fi
export EDITOR=vi
export HISTFILE="$XDG_STATE_HOME/bash/history"

#
# completions
#

export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME/bash_completion"
# export BASH_COMPLETION_USER_DIR=$XDG_DATA_HOME/bash-completion/completions  # default

# https://docs.brew.sh/Shell-Completion#configuring-completions-in-bash
if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
  source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
else
  for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
    # shellcheck disable=SC1090
    [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
  done
fi

[ ! -d "$XDG_CONFIG_HOME/bash-completion.d" ] && mkdir -p "$XDG_CONFIG_HOME/bash-completion.d"

# kubectl
if command -v kubectl >/dev/null; then
  if [[ ! -r "$XDG_CONFIG_HOME/bash-completion.d/kubectl_completion.bash" ]]; then
    kubectl completion bash >"$XDG_CONFIG_HOME/bash-completion.d/kubectl_completion.bash"
  fi
  . "$XDG_CONFIG_HOME/bash-completion.d/kubectl_completion.bash"
fi

# kind
if command -v kind >/dev/null; then
  if [[ ! -r "$XDG_CONFIG_HOME/bash-completion.d/kind_completion.bash" ]]; then
    kind completion bash >"$XDG_CONFIG_HOME/bash-completion.d/kind_completion.bash"
  fi
  . "$XDG_CONFIG_HOME/bash-completion.d/kind_completion.bash"
fi

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
