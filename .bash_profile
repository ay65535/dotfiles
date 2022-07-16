# source ~/.profile even when ~/.bash_profile exists.
test -f "$HOME/.profile" && . "$HOME/.profile"

# add ./bin to PATH
SCRIPT_ROOT=$(cd $(dirname $0); pwd)
export PATH="$PATH:$SCRIPT_ROOT/bin"
