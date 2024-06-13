#!/bin/bash

if wsl || msys && ! hash powershell.exe 2>/dev/null; then
  PATH="$PATH:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0"
fi

if [ -f "$XDG_CACHE_HOME/proxy_server.sh" ]; then
  . "$XDG_CACHE_HOME/proxy_server.sh"
elif wsl || msys; then
  # shellcheck disable=SC2016
  WINIPINFO=$(powershell.exe -nop -c 'Get-NetConnectionProfile -IPv4Connectivity Internet | sv connectionProfile; $connectionProfile | Get-NetIPInterface -AddressFamily IPv4 | sort InterfaceMetric | select -First 1 | Get-NetIPAddress | select -exp IPAddress | Write-Host -NoNewLine; "," + $connectionProfile.NetworkCategory')
  WIN_AUTO_CONFIG_URL=$(powershell.exe -nop -c 'gpv "HKCU:/Software/Microsoft/Windows/CurrentVersion/Internet Settings" AutoConfigURL' | tr -d '\r')
  WIN_PROXY_SERVER=$(powershell.exe -nop -c 'gpv "HKCU:/Software/Microsoft/Windows/CurrentVersion/Internet Settings" ProxyServer' | tr -d '\r')
  if [ -n "$WIN_PROXY_SERVER" ]; then
    BYPASS_HOST=
    PROXY_SERVER=$WIN_PROXY_SERVER
  elif [ -n "$WIN_AUTO_CONFIG_URL" ]; then
    PAC_CONTENT=$(curl -fsSL --noproxy '*' "$WIN_AUTO_CONFIG_URL")
    BYPASS_HOST=$(echo "$PAC_CONTENT" | grep -oE '\w+\.net')
    PROXY_SERVER=$(echo "$PAC_CONTENT" | grep -oP "(?<=PROXY )[\d.:]+" | grep -v '10.' | sort -u)
  fi
  if echo "$WINIPINFO" | grep -q Domain; then
    LOCATION_PROFILE=office
  else
    case "$WIN_AUTO_CONFIG_URL" in
    "" | *.jp*) LOCATION_PROFILE=home ;;
    *localhost*) LOCATION_PROFILE=vpn ;;
    *) echo "error invalid value: WIN_AUTO_CONFIG_URL='$WIN_AUTO_CONFIG_URL'" ;;
    esac
  fi
  echo -e "export PROXY_SERVER=$PROXY_SERVER\nexport LOCATION_PROFILE=$LOCATION_PROFILE${BYPASS_HOST:+\nBYPASS_HOST=$BYPASS_HOST}" >"$XDG_CACHE_HOME/proxy_server.sh"
fi

if [ "$PROXY_SERVER" != "" ] && echo "$LOCATION_PROFILE" | grep -qE "office|vpn"; then
  PROXY_URL="http://$PROXY_SERVER"

  export http_proxy="$PROXY_URL"
  export https_proxy="$PROXY_URL"
  export ftp_proxy=$PROXY_URL
  export no_proxy="127.0.0.1,localhost,::1,192.168.39.0/24,192.168.250.0/24,172.16.0.0/12,10.6.80.0/23${BYPASS_HOST:+,$BYPASS_HOST}"

  export HTTP_PROXY="$http_proxy"
  export HTTPS_PROXY="$https_proxy"
  export FTP_PROXY=$ftp_proxy
  export NO_PROXY="$no_proxy"
else
  unset http_proxy https_proxy ftp_proxy all_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY
fi
