#!/bin/bash

# https://zenn.dev/fuzmare/articles/zsh-plugin-manager-cache
# ファイル名を変数に入れる
source_dir=${XDG_CONFIG_HOME:-$HOME/.config}/mise
cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/mise
source_file="$source_dir/activate.sh"
cache_file="$cache_dir/activate.cache.sh"
eval_cmd='mise activate bash'

# キャッシュがない、またはキャッシュが古い場合にキャッシュを作成
if [ ! -r "$cache_file" ] || [ "$source_file" -nt "$cache_file" ]; then
  mkdir -p "$cache_dir"
  eval "$eval_cmd" >"$cache_file"
fi
source "$cache_file"
ls -l "$cache_file"
cat "$cache_file"
# 使い終わった変数を削除
unset source_dir cache_dir source_file cache_file eval_cmd
