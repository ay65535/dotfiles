#!/bin/zsh

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
setopt EQUALS
setopt EXTENDED_HISTORY
setopt GLOB_DOTS
setopt HIST_FIND_NO_DUPS          # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_IGNORE_ALL_DUPS       # 履歴中の重複行をファイル記録前に無くす
setopt HIST_IGNORE_DUPS           # 前と重複する行は記録しない
setopt HIST_IGNORE_SPACE          # 行頭がスペースのコマンドは記録しない
setopt HIST_NO_STORE              # histroyコマンドは記録しない
setopt HIST_REDUCE_BLANKS         # 余分な空白は詰めて記録
setopt IGNOREEOF                  # supress Ctrl-D logout
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt NUMERIC_GLOB_SORT
setopt PRINT_EIGHT_BIT
setopt PROMPT_SUBST               # Most themes use this option.
setopt PUSHD_IGNORE_DUPS
#setopt SH_WORD_SPLIT
unsetopt LIST_BEEP

HISTSIZE=100000
SAVEHIST=200000

#export HISTFILE="$XDG_STATE_HOME"/zsh/history
export HISTFILE="$ZDOTDIR/history"

if macos; then
  if type ggrep >/dev/null 2>&1; then
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

### Added by Zinit's installer
if [[ ! -f $XDG_DATA_HOME/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$XDG_DATA_HOME/zinit" && command chmod g-rwX "$XDG_DATA_HOME/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$XDG_DATA_HOME/zinit/zinit.git" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi
source "$XDG_DATA_HOME/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

if [ -f ~/.bash_aliases ]; then
    # source ~/.bash_aliases
    zinit snippet ~/.bash_aliases
fi

# Useful support for interacting with Terminal.app or other terminal programs
if [ "$TERM_PROGRAM" != 'Apple_Terminal' ]; then
  zinit snippet "$ZDOTDIR/.zshrc_shell_session"
fi

# git
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/git/git.plugin.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/git-lfs/git-lfs.plugin.zsh

# docker
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/docker-compose/docker-compose.plugin.zsh

# rust
zinit as'completion' wait'' for \
  https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/rust/_rustc

# junegunn/fzf-bin
# zinit light-mode from"gh-r" as"program" for \
#   junegunn/fzf-bin
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/fzf/fzf.plugin.zsh

# sharkdp/fd
# zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
# zinit light sharkdp/fd

# sharkdp/bat
# zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
# zinit light sharkdp/bat


# ogham/exa, replacement for ls
zinit ice wait"2" lucid from"gh-r" as"program" mv"bin/exa* -> exa"
zinit light ogham/exa

# https://github.com/so-fancy/diff-so-fancy/blob/master/pro-tips.md
zinit light-mode as:program pick:bin/git-dsf for \
  zdharma-continuum/zsh-diff-so-fancy

# zdharma-continuum/history-search-multi-word
# zstyle ":history-search-multi-word" page-size "11"
# zinit ice wait"1" lucid
# zinit load zdharma-continuum/history-search-multi-word

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh \
  as"completion" \
    https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/docker/_docker \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

case "$TERM_PROGRAM" in
  *iTerm*)
    zinit is-snippet pick'.iterm2_shell_integration.zsh' wait'!0' for \
      "${ZDOTDIR}/.iterm2_shell_integration.zsh"
  ;;
  vscode)
    VSCODE_SHELL_INTEGRATION_PATH="$(code --locate-shell-integration-path zsh)"
    zinit is-snippet pick"$VSCODE_SHELL_INTEGRATION_PATH" wait'!0' for \
      "$VSCODE_SHELL_INTEGRATION_PATH"
  ;;
esac

# Load starship theme
if hash starship; then
  case "$TERM_PROGRAM" in
    *iTerm*)
      # zinit light-mode id-as'starship' \
      #   atclone"starship init zsh --print-full-init >starship.zsh; starship completions zsh >_starship; zicompinit; zicdreplay; zinit creinstall -q _local/zinit" \
      #   atpull"%atclone" for \
      #   zdharma-continuum/null
    ;;
    *)
      # source "${ZDOTDIR}/.iterm2_shell_integration.zsh"
      # if [ ! -e starship.zsh ]; then
      #     starship init zsh --print-full-init > starship.zsh
      # fi
      # source starship.zsh
      # zinit ice id-as'starship' \
      #   atclone"starship init zsh --print-full-init > starship.zsh" \
      #   atpull"%atclone" \
      #   pick'starship.zsh' wait'!0'
      # zinit light zdharma-continuum/null
    ;;
  esac
fi

zinit light-mode \
  as"command" from"gh-r" \
  atclone"./starship init zsh >init.zsh; ./starship completions zsh >_starship" \
  atpull"%atclone" src"init.zsh" for \
  starship/starship
