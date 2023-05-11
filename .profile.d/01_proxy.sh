#!/bin/bash

if wsl || msys && ! hash powershell.exe 2>/dev/null; then
  PATH="$PATH:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0"
fi

if [ -f "$XDG_CACHE_HOME/proxy_server.sh" ]; then
  . "$XDG_CACHE_HOME/proxy_server.sh"
elif wsl || msys; then
  # shellcheck disable=SC2016
  WINIPINFO=$(powershell.exe -nop -c 'Get-NetConnectionProfile -IPv4Connectivity Internet | sv connectionProfile; $connectionProfile | Get-NetIPInterface -AddressFamily IPv4 | sort InterfaceMetric | select -First 1 | Get-NetIPAddress | select -exp IPAddress | Write-Host -NoNewLine; "," + $connectionProfile.NetworkCategory')
  WIN_HTTP_PROXY=$(powershell.exe -nop -c 'gpv "HKCU:/Software/Microsoft/Windows/CurrentVersion/Internet Settings" AutoConfigURL' | tr -d '\r')
  if [ -n "$WIN_HTTP_PROXY" ]; then
    PAC_CONTENT=$(curl -fsSL --noproxy '*' "$WIN_HTTP_PROXY")
    BYPASS_HOST=$(echo "$PAC_CONTENT" | grep -oE '\w+\.net')
    PROXY_SERVER=$(echo "$PAC_CONTENT" | grep -oP "(?<=PROXY )[\d.:]+" | grep -v '10.' | sort -u)
  fi
  if echo "$WINIPINFO" | grep -q Domain; then
    LOCATION_PROFILE=office
  else
    case "$WIN_HTTP_PROXY" in
    "" | *.jp*) LOCATION_PROFILE=home ;;
    *localhost*) LOCATION_PROFILE=vpn ;;
    *) echo "error invalid value: $$WIN_HTTP_PROXY" ;;
    esac
  fi
  echo -e "export PROXY_SERVER=$PROXY_SERVER\nexport LOCATION_PROFILE=$LOCATION_PROFILE${BYPASS_HOST:+\nBYPASS_HOST=$BYPASS_HOST}" >"$XDG_CACHE_HOME/proxy_server.sh"
fi

if [ "$PROXY_SERVER" != "" ] && echo "$LOCATION_PROFILE" | grep -qE "office|vpn"; then
  PROXY_URL="http://$PROXY_SERVER"

  export http_proxy="$PROXY_URL"
  export https_proxy="$PROXY_URL"
  export no_proxy="127.0.0.1,localhost,192.168.250.1,192.168.250.0/24${BYPASS_HOST:+,$BYPASS_HOST}"

  export HTTP_PROXY="$http_proxy"
  export HTTPS_PROXY="$https_proxy"
  export NO_PROXY="$no_proxy"
else
  unset http_proxy https_proxy ftp_proxy all_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY
fi
