export HISTFILE="$XDG_STATE_HOME/bash/history"
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME/bash-completion/bash_completion"

# https://wiki.archlinux.jp/index.php/XDG_Base_Directory_%E3%82%B5%E3%83%9D%E3%83%BC%E3%83%88#.E9.83.A8.E5.88.86.E7.9A.84.E3.81.AB.E3.82.B5.E3.83.9D.E3.83.BC.E3.83.88.E3.81.97.E3.81.A6.E3.81.84.E3.82.8B.E3.82.BD.E3.83.95.E3.83.88.E3.82.A6.E3.82.A7.E3.82.A2
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget/wget-hsts"'

if [ -n "$http_proxy" ]; then
  echo "proxy=$http_proxy" >"$HOME/curlrc"
else
  test -f "$HOME/curlrc" && rm "$HOME/curlrc"
fi
