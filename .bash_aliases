#!/bin/bash

alias q=exit

# Enable checkhash option for potential performance improvement
shopt -s checkhash

# Function to create and source cache
# 評価結果をキャッシュして読み込む関数
# $1: ツール名
# $2: 評価するコマンド
# $3: (オプション) キャッシュが古いかどうかを判断するソースファイル
create_and_source_cache() {
  local name=$1                                                    # ツール名
  local eval_cmd=$2                                                # 評価するコマンド
  local source_file=${3:-$(command -v "$name")}                    # ソースファイルの指定（デフォルトはコマンドのパス）
  local cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/eval_cache/$name # キャッシュディレクトリ
  local cache_file=$cache_dir/cache.bash                           # キャッシュファイルパス

  # ツールが存在しない場合は何もしない
  if ! command -v "$name" >/dev/null 2>&1; then
    return 0
  fi

  # source_fileが空または存在しないファイルの場合は、常に再評価する
  local should_regenerate=false
  if [[ -z "$source_file" || ! -e "$source_file" ]]; then
    should_regenerate=true
  # キャッシュが存在しないか、ソースファイルが更新されている場合
  elif [[ ! -r "$cache_file" || "$source_file" -nt "$cache_file" ]]; then
    should_regenerate=true
  fi

  # キャッシュの再生成が必要な場合
  if [[ "$should_regenerate" = true ]]; then
    mkdir -p "$cache_dir"    # キャッシュディレクトリを作成
    $eval_cmd >"$cache_file" # 評価結果をキャッシュファイルに保存
  fi

  # キャッシュファイルを読み込む（sourceより . の方がわずかに高速）
  . "$cache_file"
}

# 依存関係: mise <-- (sheldon)

# OSが検出されていない場合はデフォルト値を設定
if [[ -z "${OSDIR:-}" ]]; then
  case "$OSTYPE" in
  "linux"*) OSDIR=linux ;;
  "darwin"*) OSDIR=macos ;;
  "msys"*) OSDIR=windows ;;
  *) OSDIR=unknown ;;
  esac
fi

# Setup mise
export MISE_CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/mise/${OSDIR}
create_and_source_cache "mise" "mise activate bash"
# mise activate --shims
#export PATH="${XDG_DATA_HOME:-$HOME/.local/share}/mise/shims:$PATH"

# Setup starship
create_and_source_cache "starship" "starship init bash"

# Setup fzf
create_and_source_cache "fzf" "fzf --bash"

# Setup zoxide
create_and_source_cache "zoxide" "zoxide init bash"

# Setup sheldon
export SHELDON_CONFIG_DIR=${XDG_CONFIG_HOME:-${HOME}/.config}/sheldon/${SHELL##*/}
# sheldon の設定ファイルがない場合に備えて確認
if [ -f "$SHELDON_CONFIG_DIR/plugins.toml" ]; then
  create_and_source_cache "sheldon" "sheldon source" "$SHELDON_CONFIG_DIR/plugins.toml"
fi

# Cleanup
unset -f create_and_source_cache

# Reset
# rm -rv ~/.cache/eval_cache/*
