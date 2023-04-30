if [ ! -d "$XDG_STATE_HOME"/zsh ]; then
  mkdir -p "$XDG_STATE_HOME"/zsh
fi
export HISTFILE="$XDG_STATE_HOME"/zsh/history

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

if hash starship; then
  case "$TERM_PROGRAM" in
    *iTerm*)
      zinit ice pick'.iterm2_shell_integration.zsh' wait'!0'
      zinit snippet "${ZDOTDIR}/.iterm2_shell_integration.zsh"
      zinit ice id-as'starship' \
        atclone"starship init zsh --print-full-init > starship.zsh; starship completions zsh > _starship; zicompinit; zicdreplay; zinit creinstall -q _local/zinit" \
        atpull"%atclone"
      zinit light zdharma-continuum/null
    ;;
    *)
      # source "${ZDOTDIR}/.iterm2_shell_integration.zsh"
      # if [ ! -e starship.zsh ]; then
      #     starship init zsh --print-full-init > starship.zsh
      # fi
      # source starship.zsh
      zinit ice id-as'starship' \
        atclone"starship init zsh --print-full-init > starship.zsh" \
        atpull"%atclone" \
        pick'starship.zsh' wait'!0'
      zinit light zdharma-continuum/null
    ;;
  esac
fi
