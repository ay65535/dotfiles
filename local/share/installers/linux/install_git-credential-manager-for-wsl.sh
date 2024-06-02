#!/bin/bash
# https://learn.microsoft.com/ja-jp/windows/wsl/tutorials/wsl-git#git-credential-manager-setup

# If GIT installed is >= v2.39.0
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
# else if GIT installed is >= v2.36.1
#git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager.exe"
# else if version is < v2.36.1 enter this command:
#git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe"
