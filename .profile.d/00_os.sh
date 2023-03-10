#!/bin/bash

windows() {
  case $OS in
  *windows*) true ;;
  *) false ;;
  esac
}

macos() {
  case $OSTYPE in
  *darwin*) true ;;
  *) false ;;
  esac
}

linux() {
  case $OSTYPE in
  *linux*) true ;;
  *) false ;;
  esac
}

# case "$OSTYPE" in
#   "linux"*)  ISLINUX=1; ISMACOS= ; ISWINDOWS= ; OS=linux;;
#   "darwin"*) ISLINUX= ; ISMACOS=1; ISWINDOWS= ; OS=macos;;
#   "msys"*)   ISLINUX= ; ISMACOS= ; ISWINDOWS=1; OS=windows;;
# esac

# export ISLINUX ISMACOS ISWINDOWS

# if [[ "$ISLINUX" ]] && [[ -f '/etc/os-release' ]]; then
#   os_release="$(cat /etc/os-release)"
#   case "$os_release" in
#     *'ID=ubuntu'*) OS=ubuntu;;
#     *'ID=debian'*) OS=debian;;
#   esac
#   unset os_release
#   export OS
# fi
