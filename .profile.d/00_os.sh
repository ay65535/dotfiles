#!/bin/bash

case "$OSTYPE" in
  "linux"*)  ISLINUX=1; ISMACOS= ; ISWINDOWS= ;;
  "darwin"*) ISLINUX= ; ISMACOS=1; ISWINDOWS= ;;
  "msys"*)   ISLINUX= ; ISMACOS= ; ISWINDOWS=1;;
esac

export ISLINUX ISMACOS ISWINDOWS

if [[ "$ISLINUX" ]] && [[ -f '/etc/os-release' ]]; then
  os_release="$(cat /etc/os-release)"
  case "$os_release" in
    *'ID=ubuntu'*) OS=ubuntu;;
    *'ID=debian'*) OS=debian;;
  esac
  unset os_release
  export OS
fi
