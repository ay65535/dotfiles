#!/bin/bash
# https://github.com/git-ecosystem/git-credential-manager/blob/main/docs/credstores.md#gpgpass-compatible-files

# Create a GPG key
sudo apt update
sudo apt -y install pass

# https://gist.github.com/flbuddymooreiv/a4f24da7e0c3552942ff
gpg --full-generate-key

# Create a pass database
gpg --list-keys
GPG_ID=xxxxxxxxxxxxxx
pass init "$GPG_ID"

# Add git support to the pass database
#pass git init
# :
