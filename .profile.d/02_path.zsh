#!/usr/bin/env zsh

# -T: PATH と path を連動する。
typeset -T INFOPATH infopath
# -x: 指定された変数をエクスポート
# -U: 重複したパスを登録しない
# -g: create in global scope
typeset -xU path cdpath fpath manpath infopath xdg_data_dirs

## (N-/): 存在しないディレクトリは登録しない。
##    パス(...): ...という条件にマッチするパスのみ残す。
##            N: NULL_GLOBオプションを設定。
##               globがマッチしなかったり存在しないパスを無視する。
##            -: シンボリックリンク先のパスを評価。
##            /: ディレクトリのみ残す。

path=(
  $HOME/.docker/bin(N-/)
  $HOME/.rbenv/shims(N-/)
  $HOME/.cargo/bin(N-/)
  $HOME/.dotnet/tools(N-/)
  $HOME/.local/bin(N-/)
  $HOME/bin(N-/)
  #
  $HOMEBREW_PREFIX/share/dotnet(N-/)
  $HOMEBREW_PREFIX/opt/openjdk/bin(N-/)
  $HOMEBREW_PREFIX/opt/openssl/bin(N-/)
  #$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin(N-/)
  $HOMEBREW_PREFIX/opt/coreutils/bin(N-/)
  #
  $HOMEBREW_PREFIX/bin(N-/)
  #$HOMEBREW_PREFIX_ALT/bin(N-/)
  #
  /usr/bin(N-/)
  /bin(N-/)
  $HOMEBREW_PREFIX/sbin(N-/)
  #$HOMEBREW_PREFIX_ALT/sbin(N-/)
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
  #$HOMEBREW_PREFIX_ALT/share/man
  /usr/share/man
  # "${manpath[@]}"
)
infopath=(
  $HOMEBREW_PREFIX/share/info(N-/)
  "${infopath[@]}"
)
fpath=(
  $$HOMEBREW_PREFIX/share/zsh-completions
  "${fpath[@]}"
)
xdg_data_dirs=(
  $HOMEBREW_PREFIX/share(N-/)
  /var/lib/snapd/desktop(N-/)
  "${xdg_data_dirs[@]}"
)
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
##!

export VIMINIT=":source $XDG_CONFIG_HOME"/vim/vimrc
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

#export LANG=ja_JP.UTF-8
