#!/bin/bash
# .LINK
#   https://askubuntu.com/questions/428698/are-there-alternative-repositories-to-ports-ubuntu-com-for-arm
# .EXAMPLE
#   ./bin/find_mirrors.sh arm64 bionic main | grep FOUND | awk '{print $2}' >mirrorlist.txt

if [ $# -ne 3 ]; then
  echo "Usage: $0 <architecture> <distribution> <repository>"
  echo "Example: $0 arm64 bionic main"
  exit 1
fi

# URL of the Launchpad mirror list
MIRROR_LIST=https://launchpad.net/ubuntu/+archivemirrors

# Set to the architecture you're looking for (e.g., amd64, i386, arm64, armhf, armel, powerpc, ...).
# See https://wiki.ubuntu.com/UbuntuDevelopment/PackageArchive#Architectures
ARCH=$1
# Set to the Ubuntu distribution you need (e.g., precise, saucy, trusty, ...)
# See https://wiki.ubuntu.com/DevelopmentCodeNames
DIST=$2
# Set to the repository you're looking for (main, restricted, universe, multiverse)
# See https://help.ubuntu.com/community/Repositories/Ubuntu
REPO=$3

mirrorList=()

# Define a function to download the URL list
download_url_list() {
  if [ "$1" == "curl" ]; then
    curl -s $MIRROR_LIST
  elif [ "$1" == "wget" ]; then
    wget -qO- $MIRROR_LIST
  fi
}

# Define a function to check the header for the URL
check_url_header() {
  url="$1"
  if [ "$2" == "curl" ]; then
    curl --connect-timeout 1 -m 1 -s --head "$url/dists/$DIST/$REPO/binary-$ARCH/" | head -n 1 | grep -q "HTTP/1.[01] [23].."
  elif [ "$2" == "wget" ]; then
    wget --timeout=1 -q --spider "$url/dists/$DIST/$REPO/binary-$ARCH/" 2>&1 | grep -q "HTTP/1.[01] [23].."
  fi
}

if command -v curl >/dev/null; then
  echo "Using curl"
  downloader="curl"
elif command -v wget >/dev/null; then
  echo "Using wget"
  downloader="wget"
else
  echo "Neither curl nor wget is available on this system."
  exit 1
fi

# First, we retrieve the Launchpad mirror list, and massage it to obtain a newline-separated list of HTTP mirrors
for url in $(download_url_list $downloader | grep -Po 'http://.*(?=">http</a>)'); do
  mirrorList+=("$url")
done

for url in "${mirrorList[@]}"; do
  echo "$url"
done

# Limit the number of parallel processes
max_parallel=10
parallel=0

for url in "${mirrorList[@]}"; do
  (
    echo "Processing $url..."
    if check_url_header "$url" "$downloader"; then
      echo "FOUND: $url"
    fi
  ) &

  parallel=$((parallel + 1))

  if [ $parallel -eq $max_parallel ]; then
    wait
    parallel=0
  fi
done

wait

echo "All done!"
