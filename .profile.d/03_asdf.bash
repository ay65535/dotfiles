[ "$HOMEBREW_SHELLENV_DID_INIT" = 'false' ] && return

ASDF_PATH=$(brew --prefix asdf)
if [[ ! -e "${ASDF_PATH:-}" ]]; then
  return
fi

. "$ASDF_PATH/libexec/asdf.sh"
