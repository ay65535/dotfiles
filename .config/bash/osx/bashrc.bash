##! aliases
alias o=open
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

##! vars
SHELL_SESSION_HISTORY=1
SHELL_SESSION_HISTFILE_SHARED=$HISTFILE

##! functions
brewsci () {
    brew search $1
    echo $1 | pbcopy
    if [ -z "$ZSH_NAME" ]; then
        read "?type cask name: " caskname
    else
        read -p "type cask name: " caskname
    fi
    brew cask info $caskname
    echo 'y' | pbcopy
    if [ -z "$ZSH_NAME" ]; then
        read "?install $caskname ? (y/n): " ans
    else
        read -p "install $caskname ? (y/n): " ans
    fi
    case $ans in
        [yY]* ) brew cask install $caskname ;;
            * ) echo 'do nothing' ;;
    esac
}

# Swift
# if [ -z "$TOOLCHAINS" ]; then
#   export TOOLCHAINS=$(find ~/Library/Developer/Toolchains /Library/Developer/Toolchains \
#     -type d \
#     -name 'swift-*.xctoolchain' \
#     -exec /usr/libexec/PlistBuddy -c "Print CFBundleIdentifier:" '{}/Info.plist' \; \
#   | tail -1)
#   export PATH=/Library/Developer/Toolchains/swift-latest/usr/bin:"${PATH}"
# fi

# Homebrew ruby
#[ -x /usr/local/opt/ruby/bin/ruby ] && export PATH="/usr/local/opt/ruby/bin:$PATH"

# brew-file
# if [ -f ${HOMEBREW_PREFIX:-/usr/local}/etc/brew-wrap ]; then
#     . ${HOMEBREW_PREFIX:-/usr/local}/etc/brew-wrap
# fi

[ "$CPUTYPE" = 'x86_64' ] && [ -d $HOMEBREW_PREFIX/opt/openssl/bin ] && export PATH="$HOMEBREW_PREFIX/opt/openssl/bin:$PATH"
[ "$CPUTYPE" = 'x86_64' ] && [ -d $HOMEBREW_PREFIX/opt/curl/bin ] && export PATH="$HOMEBREW_PREFIX/opt/curl/bin:$PATH"

# rbenv
#export RUBY_CONFIGURE_OPTS="--with-openssl-dir=${HOMEBREW_PREFIX}/opt/openssl@1.1"
# type rbenv >/dev/null 2>&1 && eval "$(rbenv init -)"
if type rbenv >/dev/null 2>&1; then
    export PATH="${HOME}/.rbenv/shims:${PATH}"
    export RBENV_SHELL=${SHELL##*/}
    source "${HOMEBREW_PREFIX}/opt/rbenv/completions/rbenv.${RBENV_SHELL}"
    command rbenv rehash 2>/dev/null
    rbenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    case "$command" in
    rehash|shell)
        eval "$(rbenv "sh-$command" "$@")";;
    *)
        command rbenv "$command" "$@";;
    esac
    }
fi

# iTerm
case "$TERM_PROGRAM" in
    *iTerm*)
        if [ -n "$BASH" ]; then
            test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
        # Disabled (loaded by zplugin)
        # elif [ -n "$ZSH_NAME" ]; then
        #     test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
        fi
    ;;
esac
