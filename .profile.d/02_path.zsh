# -T: PATH と path を連動する。
typeset -T INFOPATH infopath
# -x: 指定された変数をエクスポート
# -U: 重複したパスを登録しない
# -g: create in global scope
typeset -xU path cdpath fpath manpath infopath
# typeset -U path

# $(brew --prefix) は時間がかかる処理であるため、ここで判定して HOMEBREW_PREFIX に格納する。
if [ "$CPUTYPE" = 'x86_64' ] && [[ -x '/usr/local/bin/brew' ]]; then
    HOMEBREW_PREFIX="/usr/local"
    HOMEBREW_PREFIX_ALT="$HOMEBREW_PREFIX"
elif [ "$CPUTYPE" = 'arm64' ] && [[ -x '/opt/homebrew/bin/brew' ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
    HOMEBREW_PREFIX_ALT="/usr/local"  # for cask installer
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    HOMEBREW_PREFIX_ALT="$HOMEBREW_PREFIX"
else
    HOMEBREW_PREFIX="/tmp"
    HOMEBREW_PREFIX_ALT="$HOMEBREW_PREFIX"
fi

export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
export HOMEBREW_PREFIX HOMEBREW_PREFIX_ALT

## (N-/): 存在しないディレクトリは登録しない。
##    パス(...): ...という条件にマッチするパスのみ残す。
##            N: NULL_GLOBオプションを設定。
##               globがマッチしなかったり存在しないパスを無視する。
##            -: シンボリックリンク先のパスを評価。
##            /: ディレクトリのみ残す。

# if setopt | grep -q noglobalrcs; then
    # if [ -x /usr/libexec/path_helper ]; then
        # eval `/usr/libexec/path_helper -s`
        # command ls -1d $HOMEBREW_PREFIX/opt/*/bin
        # command ls -1d $HOMEBREW_PREFIX_ALT/opt/*/bin
        # echo "--\n$PATH\n--" | tr : '\n'
path=(
    ~/.rbenv/shims(N-/)
    ~/.cargo/bin(N-/)
    ~/.dotnet/tools(N-/)
    ~/.local/bin(N-/)
    ~/bin(N-/)
    #
    $HOMEBREW_PREFIX/share/dotnet(N-/)
    $HOMEBREW_PREFIX/opt/openjdk/bin(N-/)
    $HOMEBREW_PREFIX/opt/openssl/bin(N-/)
    #$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin(N-/)
    $HOMEBREW_PREFIX/opt/coreutils/bin(N-/)
    #
    $HOMEBREW_PREFIX/bin(N-/)
    $HOMEBREW_PREFIX_ALT/bin(N-/)
    #
    /usr/bin(N-/)
    /bin(N-/)
    $HOMEBREW_PREFIX/sbin(N-/)
    $HOMEBREW_PREFIX_ALT/sbin(N-/)
    #
    /usr/sbin(N-/)
    /sbin(N-/)
    #
    /Library/Apple/usr/bin(N-/)
    /Library/Frameworks/Mono.framework/Versions/Current/Commands(N-/)
    /opt/X11/bin(N-/)
            # "${path[@]}"
        )
        manpath=(
            $HOMEBREW_PREFIX/share/man
            $HOMEBREW_PREFIX_ALT/share/man
            /usr/share/man
            # "${manpath[@]}"
)
        infopath=(
            $HOMEBREW_PREFIX/share/info(N-/)
            "${infopath[@]}"
        )
        xdg_data_dirs=(
            $HOMEBREW_PREFIX/share(N-/)
            /var/lib/snapd/desktop(N-/)
            "${xdg_data_dirs[@]}"
        )
    # fi
# fi
# echo ${(t)path}
# echo ${(t)cdpath}
# echo ${(t)fpath}
# echo ${(t)manpath}
# echo ${(t)infopath}
# echo ${(t)PATH}
# echo ${(t)CDPATH}
# echo ${(t)FPATH}
# echo ${(t)MANPATH}
# echo ${(t)INFOPATH}
export CDPATH FPATH MANPATH INFOPATH
##!

export VIMINIT=":source $XDG_CONFIG_HOME"/vim/vimrc
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

#export LANG=ja_JP.UTF-8
