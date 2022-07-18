# setopt no_global_rcs

if globexists ~/.profile.d/*.*(z)sh; then
  for f in ~/.profile.d/*.*(z)sh; do
    . "$f"
  done
fi

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
