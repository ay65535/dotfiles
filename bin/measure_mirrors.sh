#!/bin/bash
# .LINK
#   https://zenn.dev/tetsu_koba/articles/c980cb3371c4bb
# .EXAMPLE
#   ./bin/measure_mirrors.sh ./mirrorlist.txt

LIST=${1:-./mirrorlist.txt}

ARCH=arm64
DIST=bionic
REPO=main

# if $LIST not contains http://ports.ubuntu.com/ then add it to the beginning of the list
if ! grep -q "http://ports.ubuntu.com/" "$LIST"; then
  sed -i "1i http://ports.ubuntu.com/" "$LIST"
fi

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

while IFS= read -r url; do
  echo -n "$url"
  if [ "$downloader" == "curl" ]; then
    curl -w "  code: %{http_code}, speed: %{speed_download}\n" -o /dev/null -s "$url/dists/$DIST/$REPO/binary-$ARCH/"
  elif [ "$downloader" == "wget" ]; then
    start_time=$(date +%s.%N)
    wget -q --timeout=10 -O /dev/null "$url/dists/$DIST/$REPO/binary-$ARCH/"
    wget_exit_code=$?
    end_time=$(date +%s.%N)
    elapsed=$(echo "$end_time - $start_time" | bc)
    speed=$(echo "scale=2; 1 / $elapsed" | bc)
    if [ $wget_exit_code -eq 0 ]; then
      code=200
    else
      code=$(wget --timeout=10 -S -O /dev/null "$url/dists/$DIST/$REPO/binary-$ARCH/" 2>&1 | grep "HTTP/" | awk '{print $2}')
    fi
    echo "  code: $code, speed: $speed"
  fi
done <"$LIST"
