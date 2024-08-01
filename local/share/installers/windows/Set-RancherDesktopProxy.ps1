<#
.LINK
    [Windows Rancher Desktop が proxy環境で docker run hello-world できない人の Tips #Docker - Qiita](https://qiita.com/RyoWakabayashi/items/158e6957d362709dc4d6#proxy-%E8%A8%AD%E5%AE%9A)
#>

# パスを通す
# if (!(Get-Command wsl.exe -ErrorAction SilentlyContinue)) {
#     $env:PATH = "${env:PATH}:/mnt/c/WINDOWS/system32"
# }

wsl.exe --list --verbose

wsl.exe --distribution rancher-desktop grep proxy /etc/rc.conf

# /etc/rc.conf に以下を追記
@"
rc_env_allow="https_proxy http_proxy no_proxy"
export https_proxy="$env:https_proxy"
export http_proxy="$env:http_proxy"
export no_proxy="$env:no_proxy"
"@

wsl.exe --distribution rancher-desktop
# vi /etc/rc.conf
# exit

wsl.exe --terminate Ubuntu-24.04
wsl.exe --shutdown

# 追記後、 exit で WSL から抜けて Windows を再起動すると、
docker info
docker run --rm hello-world
