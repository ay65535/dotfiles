set -eu

#
# Script Variables
#

# SCRIPT_ROOT=$HOME/.dotfiles
SCRIPT_ROOT="$(cd "$(dirname "$0")" && pwd)"

#
# Functions
#

symlink_to_home () {
  # 1st param is: filename to symlink
  local link_name="$1"
  local link_dir="$HOME"
  local link_path="$link_dir/$link_name"
  local orig_fullpath="$SCRIPT_ROOT/$link_name"

  # check original file existence
  if [[ ! -e "$orig_fullpath" ]]; then
    echo "$orig_fullpath is not found, do nothing." >&2
    return
  fi

  # check symlink existence
  if [[ -e "$link_path" ]]; then
    echo "$link_path is already exists, do nothing." >&2
    return
  fi

  # get relative path
  local orig_relpath="$(realpath --relative-to="$link_dir" "$orig_fullpath")"

  ln -snfv "$orig_relpath" "$link_path"
}

#
# Main
#

TARGET=($(ls -A1 "$SCRIPT_ROOT" | grep -E '^\..+$' | grep -v '^\.git.*$'))
TARGET+=(bin)

for f in "${TARGET[@]}"; do
  symlink_to_home "$f"
done

if [ ! -f "$SCRIPT_ROOT/.config/git/config" ] && [ ! -f "$HOME/.gitconfig" ]; then
  git config --file "$SCRIPT_ROOT/.config/git/config" include.path config.core
fi
