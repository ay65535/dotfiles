#!/bin/bash

if windows && ! hash powershell.exe 2>/dev/null; then
  PATH="$PATH:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0"
fi

if [ -f "$XDG_CACHE_HOME/proxy_server.sh" ]; then
  . "$XDG_CACHE_HOME/proxy_server.sh"
elif windows; then
  # shellcheck disable=SC2016
  WINIPS=$(powershell.exe -nop -c 'gip | ? IPAddress -Match "^10\." | select -exp IPAddress')
  WIN_HTTP_PROXY=$(powershell.exe -nop -c 'gp "HKCU:/Software/Microsoft/Windows/CurrentVersion/Internet Settings" | select -exp AutoConfigURL -ErrorAction SilentlyContinue')
  if [ -n "$WIN_HTTP_PROXY" ]; then
    PROXY_SERVER=$(curl -fsSL --noproxy .net "$WIN_HTTP_PROXY" | grep -oP "(?<=PROXY )[\d.:]+" | grep -v '10.' | sort -u)
  fi
  if echo "$WINIPS" | grep -q "^10\."; then
    LOCATION_PROFILE=office
  else
    case "$WIN_HTTP_PROXY" in
    "" | *.jp*) LOCATION_PROFILE=home ;;
    *localhost*) LOCATION_PROFILE=vpn ;;
    *) echo "error invalid value: $$WIN_HTTP_PROXY" ;;
    esac
  fi
  echo -e "export PROXY_SERVER=$PROXY_SERVER\nexport LOCATION_PROFILE=$LOCATION_PROFILE" >"$XDG_CACHE_HOME/proxy_server.sh"
fi

if [ "$PROXY_SERVER" != "" ] && echo "$LOCATION_PROFILE" | grep -qE "office|vpn"; then
  PROXY_URL="http://$PROXY_SERVER"

  export http_proxy="$PROXY_URL"
  export https_proxy="$PROXY_URL"
  export no_proxy='127.0.0.1,localhost,192.168.250.1,192.168.250.0/24,.net'

  export HTTP_PROXY="$http_proxy"
  export HTTPS_PROXY="$https_proxy"
  export NO_PROXY="$no_proxy"
else
  unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
fi
