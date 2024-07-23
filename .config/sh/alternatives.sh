#!/bin/bash

# コマンドのエイリアスを設定する関数
set_command_alias() {
  local cmd_alias=$1
  shift
  local cmds=("$@")

  for cmd in "${cmds[@]}"; do
    if [[ "$cmd" == "$cmd_alias" ]]; then
      # エイリアス名と同じコマンドの場合、エイリアスを張らない
      break
    elif command -v "$cmd" >/dev/null 2>&1; then
      alias "$cmd_alias"="$cmd"
      break
    fi
  done
}

# alternative to ls
ALTERNATIVE_LS=(eza exa gls ls)
set_command_alias ls "${ALTERNATIVE_LS[@]}"

# alternative to cd
ALTERNATIVE_CD=(zoxide z gcd cd)
set_command_alias cd "${ALTERNATIVE_CD[@]}"

# alternative to find
ALTERNATIVE_FIND=(fd gfind find)
set_command_alias find "${ALTERNATIVE_FIND[@]}"

# alternative to grep
ALTERNATIVE_GREP=(rg ggrep grep)
set_command_alias grep "${ALTERNATIVE_GREP[@]}"

# alternative to cat
ALTERNATIVE_CAT=(bat batcat gat gcat cat)
set_command_alias cat "${ALTERNATIVE_CAT[@]}"

# alternative to diff
ALTERNATIVE_DIFF=(delta gdiff diff)
set_command_alias diff "${ALTERNATIVE_DIFF[@]}"

# alternative to du
ALTERNATIVE_DU=(dust gdu du)
set_command_alias du "${ALTERNATIVE_DU[@]}"

# alternative to df
ALTERNATIVE_DF=(duf gdf df)
set_command_alias df "${ALTERNATIVE_DF[@]}"

# alternative to top
ALTERNATIVE_TOP=(bottom htop gtop top)
set_command_alias top "${ALTERNATIVE_TOP[@]}"

# alternative to ps
ALTERNATIVE_PS=(procs gps ps)
set_command_alias ps "${ALTERNATIVE_PS[@]}"
