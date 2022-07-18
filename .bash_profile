## Options
shopt -s extglob

## Functions
globexists () {
  # https://stackoverflow.com/questions/6363441/check-if-a-file-exists-with-a-wildcard-in-a-shell-script
  compgen -G "$1" >/dev/null || [ -e "$1" ]
}

## Main

# source ~/.profile.d/*.sh if it exists.
if globexists ~/.profile.d/*.*(ba)sh; then
  for f in ~/.profile.d/*.*(ba)sh; do
    . "$f"
  done
fi

# source ~/.profile even when ~/.bash_profile exists.
test -f "$HOME/.profile" && . "$HOME/.profile"
