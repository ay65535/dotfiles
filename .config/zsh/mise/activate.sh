#!/bin/zsh

# https://zenn.dev/fuzmare/articles/zsh-plugin-manager-cache
# ファイル名を変数に入れる
target_dir=$ZDOTDIR/mise
cache_file="$target_dir/activate.cache.zsh"
source_file="$target_dir/activate.sh"
eval_cmd='mise activate zsh'

ensure_zcompiled $source_file

# キャッシュがない、またはキャッシュが古い場合にキャッシュを作成
if [[ ! -r "$cache_file" || "$source_file" -nt "$cache_file" ]]; then
  mkdir -p "$target_dir"
  eval "$eval_cmd" >"$cache_file"
fi
source "$cache_file"
# 使い終わった変数を削除
unset target_dir cache_file source_file
