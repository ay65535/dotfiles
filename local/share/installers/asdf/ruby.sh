#!/usr/bin/env bash

asdf list ruby
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf list-all ruby
#asdf install ruby 3.3.1
#asdf global ruby 3.3.1
asdf install ruby latest
asdf global ruby latest
ruby -v

# asdf local ruby latest
# ruby -v
# cat .tool-versions
