# https://docs.brew.sh/Homebrew-on-Linux

# deps
sudo apt-get install build-essential procps curl file git

if [[ "$(uname -m)" == "aarch64" ]]; then
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o homebrew_install.sh
  # patch
  perl -i -0pe 's/abort "\$\(\n *cat <<EOABORT\nHomebrew on Linux is not supported on ARM processors\.\n.*\n.*\nEOABORT\n\s*\)"/: # do nothing/m' homebrew_install.sh
  chmod +x homebrew_install.sh
  /bin/bash homebrew_install.sh
  rm -i homebrew_install.sh
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
