#!/bin/bash

# Homebrewが既に環境に設定されているかをチェックする関数
check_brew_initialized() {
  # PATH内にHomebrewのパスが含まれていれば初期化済みと判断
  if [ -n "$HOMEBREW_PREFIX" ] && echo "$PATH" | grep -q "$HOMEBREW_PREFIX/bin"; then
    return 0
  fi
  return 1
}

# Linuxbrew用の環境設定
# test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# を関数化
setup_linuxbrew() {
  local prefix="/home/linuxbrew/.linuxbrew"

  # ディレクトリが存在しない場合はスキップ
  if [ ! -d "$prefix" ]; then
    return 1
  fi

  # PATHを設定（既存のPATHの前に追加）
  if ! echo "$PATH" | grep -q "$prefix/bin"; then
    export PATH="$prefix/bin:$prefix/sbin${PATH+:$PATH}"
  fi

  # 環境変数を設定
  export HOMEBREW_PREFIX="$prefix"
  export HOMEBREW_CELLAR="$prefix/Cellar"
  export HOMEBREW_REPOSITORY="$prefix/Homebrew"

  # MANPATHとINFOPATHを設定
  [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
  export INFOPATH="$prefix/share/info${INFOPATH+:$INFOPATH}"

  return 0
}

# macOS用のHomebrew環境設定
setup_macos_homebrew() {
  if ! macos; then
    return 1
  fi

  local prefix
  if [ "$(uname -m)" = "arm64" ]; then
    prefix="/opt/homebrew"
  else
    prefix="/usr/local"
  fi

  # ディレクトリが存在しない場合はスキップ
  [ -d "$prefix" ] || return 1

  # 既に初期化済みならスキップ
  if [ "$HOMEBREW_PREFIX" = "$prefix" ]; then
    return 0
  fi

  # 環境変数を直接設定
  export HOMEBREW_PREFIX="$prefix"
  export HOMEBREW_CELLAR="$prefix/Cellar"
  export HOMEBREW_REPOSITORY="$prefix/Homebrew"

  # PATHを設定（既存のPATHの前に追加）
  if ! echo "$PATH" | grep -q "$prefix/bin"; then
    export PATH="$prefix/bin:$prefix/sbin${PATH+:$PATH}"
  fi

  # MANPATHとINFOPATHを設定
  [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
  export INFOPATH="$prefix/share/info:${INFOPATH:-}"

  return 0
}

# メイン処理
main() {
  # 既に初期化済みなら何もしない
  check_brew_initialized && return 0

  # プラットフォームに応じたHomebrew環境を順番に試行
  setup_macos_homebrew || setup_linuxbrew

  # プロキシ設定がある場合のHomebrewの設定
  if [ -n "$https_proxy" ] && command -v brew >/dev/null; then
    if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/.curlrc" ]; then
      export HOMEBREW_CURLRC="${XDG_CONFIG_HOME:-$HOME/.config}/.curlrc"
    fi
  fi
}

# スクリプト実行
main
