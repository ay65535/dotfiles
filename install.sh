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

# check os
set -x
case "$OSTYPE" in
  "linux"*) OSDIR=linux ;;
  "darwin"*) OSDIR=macos ;;
  "msys"*) OSDIR=windows ;;
  *) OSDIR=unknown
esac


# setup .gitconfig

git config --get-all include.path | grep -q config.core
if [[ "$?" == "1" ]]; then
  if [ ! -f "$HOME/.gitconfig" ]; then
    git config --file "$SCRIPT_ROOT/.config/git/config" --add include.path config.core

    git config --get-all include.path | grep -q $OSDIR/config
    if [[ "$?" == "1" ]] && [[ "$OSDIR" != 'unknown' ]]; then
      git config --file "$SCRIPT_ROOT/.config/git/config" --add include.path $OSDIR/config
    fi

  elif [ -f "$HOME/.gitconfig" ]; then
    git config --add include.path config.core

    git config --get-all include.path | grep -q $OSDIR/config
    if [[ "$?" == "1" ]] && [[ "$OSDIR" != 'unknown' ]]; then
      git config --add include.path $OSDIR/config
    fi

    if [ -f "$SCRIPT_ROOT/.config/git/config" ]; then
      echo "both ~/.gitconfig and ~/.config/git/config exists."
    fi
  fi
fi

# setup bash_completion
if [[ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions" ]]; then
  mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions"
fi
