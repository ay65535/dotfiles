available() {
    local x candidates
    candidates="$1:"
    while [ -n "$candidates" ]; do
        x=${candidates%%:*}
        candidates=${candidates#*:}
        if type "$x" >/dev/null 2>&1; then
            echo "$x"
            return 0
        else
            continue
        fi
    done
    return 1
}
FILTER=$(available "$INTERACTIVE_FILTER")

if [[ "$FILTER" != "" ]]; then

    if [ -n "$ZSH_NAME" ]; then
        peco-src() {
            local selected
            # shellcheck disable=SC2153
            selected="$(ghq list --full-path | peco --query="$LBUFFER")"
            if [ -n "$selected" ]; then
                # shellcheck disable=SC2034
                BUFFER="builtin cd $selected"
                # zle accept-line
            fi
            zle reset-prompt
        }
        zle -N peco-src
        bindkey '^]' peco-src
    elif [ -n "$BASH" ]; then
        # Require Bash 4.0+
        peco-src() {
            local selected
            selected="$(ghq list --full-path | $FILTER --query="$READLINE_LINE")"
            if [ -n "$selected" ]; then
                READLINE_LINE="builtin cd $selected"
                READLINE_POINT=${#READLINE_LINE}
            fi
        }
        bind -x '"\C-]": peco-src'

        # fshow - git commit browser (enter for show, ctrl-d for diff)
        fshow() {
            local out shas sha q k
            while out=$(
                git log --graph --color=always \
                    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
                    $FILTER --ansi --multi --no-sort --reverse --query="$q" \
                        --print-query --expect=ctrl-d
            ); do
                q=$(head -1 <<<"$out")
                k=$(head -2 <<<"$out" | tail -1)
                shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<<"$out" | awk '{print $1}')
                [ -z "$shas" ] && continue
                if [ "$k" = ctrl-d ]; then
                    git diff --color=always "$shas" | less -R
                else
                    for sha in $shas; do
                        git show --color=always "$sha" | less -R
                    done
                fi
            done
        }

        # Another CTRL-R script to insert the selected command from history into the command line/region
        SED=$(available gsed:sed)
        if [ "$FILTER" == 'fzf' ]; then
            OPTIONS='+s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r'
        elif [ "$FILTER" == 'fzy' ]; then
            OPTIONS=''
        fi

        __fzf_history() {
            # builtin history -a;
            # builtin history -c;
            # builtin history -r $SHELL_SESSION_HISTFILE_SHARED;
            READLINE_LINE_NEW="$(
                HISTTIMEFORMAT=builtin history |
                    command $FILTER "$OPTIONS" |
                    command $SED '
                    /^ *[0-9]/ {
                        s/ *\([0-9]*\) .*/!\1/;
                        b end;
                    };
                    d;
                    : end
                '
            )"
            builtin typeset READLINE_LINE_NEW

            if [[ -n $READLINE_LINE_NEW ]]; then
                builtin bind '"\er": redraw-current-line'
                builtin bind '"\e^": magic-space'
                READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
                READLINE_POINT=$((READLINE_POINT + ${#READLINE_LINE_NEW}))
            else
                builtin bind '"\er":'
                builtin bind '"\e^":'
            fi
        }
        #builtin set -o histexpand;
        builtin bind -x '"\C-x1": __fzf_history'
        builtin bind '"\C-r": "\C-x1\e^\er"'
    fi
fi

if available 'diff-so-fancy' >/dev/null 2>&1; then
    diff() {
        command diff "$@" | diff-so-fancy
    }
fi
