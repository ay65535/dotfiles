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
# for WSL
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"

# clone
git clone --recurse-submodules https://ay65535@github.com/ay65535/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```
