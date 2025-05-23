#!/usr/bin/env zsh

function source {
  ensure_zcompiled $1
  builtin source $1
}
function ensure_zcompiled {
  local compiled="$1.zwc"
  if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
    echo "Compiling $1"
    zcompile $1
  fi
}
ensure_zcompiled ${XDG_CONFIG_HOME}/zsh/.zshrc

#
# Options
#

setopt AUTO_CD
setopt AUTO_LIST
setopt AUTO_MENU
setopt AUTO_PARAM_KEYS
setopt AUTO_PARAM_SLASH
setopt AUTO_PUSHD
setopt AUTO_RESUME
setopt BASH_AUTO_LIST
setopt EQUALS
setopt EXTENDED_HISTORY
setopt GLOB_DOTS
setopt HIST_FIND_NO_DUPS    # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_IGNORE_ALL_DUPS # 履歴中の重複行をファイル記録前に無くす
setopt HIST_IGNORE_DUPS     # 前と重複する行は記録しない
setopt HIST_IGNORE_SPACE    # 行頭がスペースのコマンドは記録しない
setopt HIST_NO_STORE        # histroyコマンドは記録しない
setopt HIST_REDUCE_BLANKS   # 余分な空白は詰めて記録
setopt IGNOREEOF            # supress Ctrl-D logout
setopt INTERACTIVE_COMMENTS
setopt LIST_AMBIGUOUS
setopt NO_BEEP
setopt NO_LIST_BEEP
setopt NO_MENUCOMPLETE
setopt NUMERIC_GLOB_SORT
setopt PRINT_EIGHT_BIT
setopt PROMPT_SUBST # Most themes use this option.
setopt PUSHD_IGNORE_DUPS
#setopt SH_WORD_SPLIT

HISTSIZE=100000
SAVEHIST=200000

#export HISTFILE="$XDG_STATE_HOME"/zsh/history
export HISTFILE="$ZDOTDIR/history"

if macos; then
  if type gls >/dev/null 2>&1; then
    GNU_COREUTILS=1
    GNU_PREFIX='g'
  else
    GNU_COREUTILS=0
    GNU_PREFIX=''
  fi
elif linux; then
  GNU_COREUTILS=1
  GNU_PREFIX=''
fi
# enable color support of ls and also add handy aliases
if [ "$GNU_COREUTILS" = 1 ]; then
  alias ls="${GNU_PREFIX}ls --color=auto"
  # alias dir="${GNU_PREFIX}dir --color=auto"
  # alias vdir="${GNU_PREFIX}vdir --color=auto"
  alias grep="${GNU_PREFIX}grep --color=auto"
  alias fgrep="${GNU_PREFIX}fgrep --color=auto"
  alias egrep="${GNU_PREFIX}egrep --color=auto"
else
  alias ls='ls -G'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ "$OSTYPE" = darwin ] && ! grep -q pam_tid.so /etc/pam.d/sudo; then
  [ ! -f /etc/pam.d/sudo.orig ] && sudo ditto /etc/pam.d/sudo /etc/pam.d/sudo.orig
  if command -v gsed; then
    echo "Adding pam_tid.so to /etc/pam.d/sudo"
    sudo gsed -i'' '2i auth       sufficient     pam_tid.so' /etc/pam.d/sudo
  fi
fi

if command -v brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

### sheldon
#export SHELDON_CONFIG_DIR=${XDG_CONFIG_HOME:-${HOME}/.config}/sheldon/${SHELL##*/}
# eval "$(sheldon source)"
# https://zenn.dev/fuzmare/articles/zsh-plugin-manager-cache
# ファイル名を変数に入れる
cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
sheldon_cache="$cache_dir/sheldon.zsh"
sheldon_toml="${XDG_CONFIG_HOME:-$HOME/.config}/sheldon/plugins.toml"
# キャッシュがない、またはキャッシュが古い場合にキャッシュを作成
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  mkdir -p $cache_dir
  sheldon source >$sheldon_cache
fi
source "$sheldon_cache"
# 使い終わった変数を削除
unset cache_dir sheldon_cache sheldon_toml

### Added by Zinit's installer
# if [[ ! -f $XDG_DATA_HOME/zinit/zinit.git/zinit.zsh ]]; then
#   print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
#   command mkdir -p "$XDG_DATA_HOME/zinit" && command chmod g-rwX "$XDG_DATA_HOME/zinit"
#   command git clone https://github.com/zdharma-continuum/zinit "$XDG_DATA_HOME/zinit/zinit.git" && \
#     print -P "%F{33} %F{34}Installation successful.%f%b" || \
#     print -P "%F{160} The clone has failed.%f%b"
# fi
# source "$XDG_DATA_HOME/zinit/zinit.git/zinit.zsh"
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit

# if [ -f ~/.bash_aliases ]; then
#     # source ~/.bash_aliases
#     zinit snippet ~/.bash_aliases
# fi

# Useful support for interacting with Terminal.app or other terminal programs
# if [ "$TERM_PROGRAM" != 'Apple_Terminal' ]; then
#   zinit snippet "$ZDOTDIR/.zshrc_shell_session"
# fi

# git
# zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/git/git.plugin.zsh
# zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/git-lfs/git-lfs.plugin.zsh

# docker
# zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/docker-compose/docker-compose.plugin.zsh

# rust
# zinit as'completion' wait'' for \
#   https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/rust/_rustc

# junegunn/fzf-bin
FZF_DEFAULT_OPTS='--height=15 --reverse --inline-info --color=dark --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'
# zinit light-mode from"gh-r" as"program" for \
#   junegunn/fzf
# zinit has'fzf' for \
#   https://github.com/junegunn/fzf/raw/master/shell/key-bindings.zsh
# zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/fzf/fzf.plugin.zsh

# sharkdp/fd
# zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
# zinit light sharkdp/fd

# sharkdp/bat
# zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
# zinit light sharkdp/bat

# ogham/exa, replacement for ls
# zinit ice wait"2" lucid from"gh-r" as"program" mv"bin/exa* -> exa"
# zinit light ogham/exa

# https://github.com/so-fancy/diff-so-fancy/blob/master/pro-tips.md
# zinit lucid as:program pick:bin/git-dsf for \
#   zdharma-continuum/zsh-diff-so-fancy

# zdharma-continuum/history-search-multi-word
# zstyle ":history-search-multi-word" page-size "11"
# zinit wait"1" lucid for \
#   zdharma-continuum/history-search-multi-word

# zinit wait lucid light-mode for \
#   atinit"zicompinit; zicdreplay; zmodload -i zsh/complist" \
#     zdharma-continuum/fast-syntax-highlighting \
#     https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh \
#   as"completion" \
#     https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/docker/_docker \
#   atload"_zsh_autosuggest_start" \
#     zsh-users/zsh-autosuggestions \
#   blockf atpull'zinit creinstall -q .' \
#     zsh-users/zsh-completions

# This setting slows down fzf history filtering.
# also, iTerm2's 'Load shell integration automatically' must be disabled.
# if [ "$TERM_PROGRAM" = 'iTerm.app' ]; then
#   zinit is-snippet pick'.iterm2_shell_integration.zsh' wait'!0' for \
#     "${ZDOTDIR}/.iterm2_shell_integration.zsh"
# fi

# Load starship theme
# zinit light-mode \
#   as"command" from"gh-r" \
#   atclone"./starship init zsh >init.zsh; ./starship completions zsh >_starship" \
#   atpull"%atclone" src"init.zsh" for \
#   starship/starship

# unfunction source
