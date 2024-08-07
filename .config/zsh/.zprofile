## Functions
globexists () {
  # https://stackoverflow.com/questions/41502846/zsh-test-whether-a-file-matching-a-pattern-exists
  [[ -n *$1*(#qN) ]]
}

# source ~/.profile.d/*.sh if it exists.
setopt extendedglob
unsetopt nomatch
local -a files
files=($(find ~/.profile.d/ -maxdepth 1 -regex '.*\.z?sh$' | sort))
for file in $files; do
  . "$file"
done
if [ -d ~/.profile.d/${OSDIR:?} ]; then
  files=($(find ~/.profile.d/${OSDIR:?} -regex '.*\.z?sh$' | sort))
  for file in $files; do
    . "$file"
  done
fi

# Resume Support: Save/Restore Shell State
#
# The default behavior arranges to save and restore the shell command
# history independently for each restored terminal session. It also
# merges commands into the global history for new sessions. Because of
# this it is recommended that you set HISTSIZE and SAVEHIST to larger
# values.
HISTSIZE=100000
SAVEHIST=200000

# You may disable this behavior and share a single history by setting
# SHELL_SESSION_HISTORY to 0. The shell options INC_APPEND_HISTORY,
# INC_APPEND_HISTORY_TIME and SHARE_HISTORY are used to share new
# commands among running shells; therefore, if any of these is enabled,
# per-session history is disabled by default. You may explicitly enable
# it by setting SHELL_SESSION_HISTORY to 1.
#unsetopt APPEND_HISTORY
unsetopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY
SHELL_SESSION_HISTORY=1
