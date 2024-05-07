#!/bin/bash
# https://qiita.com/katoken-0215/items/18f9b8553f8ad4117d79#%E4%BB%96%E3%81%AE%E4%BA%BA%E3%81%AE%E8%A7%A3%E7%AE%A1%E7%90%86%E8%80%85%E3%82%A2%E3%82%AB%E3%82%A6%E3%83%B3%E3%83%88%E3%81%8C%E3%81%82%E3%82%8B%E5%A0%B4%E5%90%88

if [ ! -f /etc/sudoers.d/00_proxy ]; then
    # sudo cat /etc/sudoers.d/README
    echo 'Defaults:%sudo env_keep += "http_proxy https_proxy ftp_proxy all_proxy no_proxy"' | sudo tee /etc/sudoers.d/00_proxy
    # sudo cat /etc/sudoers.d/00_proxy
fi
