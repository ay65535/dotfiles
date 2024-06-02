# https://learn.microsoft.com/ja-jp/powershell/scripting/install/installing-powershell-on-macos

if ! command -v brew 2>&1 >/dev/null; then
  echo "Install Homebrew or Linuxbrew first!" >&2
  exit 1
fi

if [ $(uname) = "Linux" ]; then
  # brew install --build-from-source powershell/tap/powershell
  echo "Linux not supported!" >&2
  exit 2
else
  brew install powershell/tap/powershell
fi

# Uninstall
#brew uninstall powershell
