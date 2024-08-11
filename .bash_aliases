#!/bin/bash

# Enable checkhash option for potential performance improvement
shopt -s checkhash

# Function to create and source cache
create_and_source_cache() {
  local name=$1
  local eval_cmd=$2
  local source_file=${3:-$(command -v "$name")}
  local cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/$name
  local cache_file=$cache_dir/cache.bash

  if [[ ! -r "$cache_file" || "$source_file" -nt "$cache_file" ]]; then
    mkdir -p "$cache_dir"
    $eval_cmd >"$cache_file"
  fi

  # Use . instead of source for slight performance improvement
  . "$cache_file"
}

# Setup mise
export MISE_CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/mise/${OSDIR:?}
# mise activate --shims
create_and_source_cache "mise" "mise activate bash"
export PATH="${XDG_DATA_HOME:-$HOME/.local/share}/mise/shims:$PATH"

# Setup starship
create_and_source_cache "starship" "starship init bash"

# Setup fzf
create_and_source_cache "fzf" "fzf --bash"

# Setup zoxide
create_and_source_cache "zoxide" "zoxide init bash"

# Setup sheldon
export SHELDON_CONFIG_DIR=${XDG_CONFIG_HOME:-${HOME}/.config}/sheldon/${SHELL##*/}
create_and_source_cache "sheldon" "sheldon source" "$SHELDON_CONFIG_DIR/plugins.toml"

# Cleanup
unset -f create_and_source_cache

# Reset
# rm -v ~/.cache/mise/cache.bash
# rm -v ~/.cache/starship/cache.bash
# rm -v ~/.cache/fzf/cache.bash
# rm -v ~/.cache/zoxide/cache.bash
# rm -v ~/.cache/sheldon/cache.bash
