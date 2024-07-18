# dotfiles

## Concept

* Support for GitHub Codespaces dotfiles autoloading.
* Use default rc files and do not edit or overwrite them.
  * Examples
    * debian / ubuntu:
      * default: .profile, .bashrc, .bash_logout
      * add (by symbolic link): .bash_profile, .bash_aliases
    * Git Bash: TBD
    * msys2: TBD
    * macOS (zsh): TBD
* Many initial setup and installation scripts included

## Install

```sh
# for WSL # (https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-git)
# If GIT installed is >= v2.39.0
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
# else if GIT installed is >= v2.36.1
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager.exe"
# else if version is < v2.36.1 enter this command:
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe"


# clone #
git clone --recurse-submodules https://ay65535@github.com/ay65535/dotfiles-ay65535.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```
